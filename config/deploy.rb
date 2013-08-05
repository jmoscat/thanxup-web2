require 'bundler/capistrano'

set :application, "r3devboot"
set :repository,  "https://github.com/jehughes/rails3-devise-bootstrap-example.git"
set :deploy_to, "/home/jehughes/webapps/#{application}"

set :scm, :git 

role :web, "web335.webfaction.com"  # Your HTTP server, Apache/etc
role :app, "web335.webfaction.com"  # This may be the same as your `Web` server
role :db,  "web335.webfaction.com", :primary => true # This is where Rails migrations will run

set :user, "jehughes"
set :scm_username, "jehughes"
set :use_sudo, false
default_run_options[:pty] = true
set :keep_releases, 3

before "deploy:finalize_update", "deploy:assets:symlink"
after  "deploy:update_code", "deploy:assets:precompile"

after  "deploy", "deploy:migrate"
before "deploy:migrate", "deploy:copy_git_ignored_files"

after  "deploy:migrate", "deploy:restart_passenger"
before "deploy:restart_passenger", "deploy:cleanup"

namespace :deploy do

  # http://www.rostamizadeh.net/blog/2012/04/14/precompiling-assets-locally-for-capistrano-deployment/
  namespace :assets do
    task :precompile, :roles => :web do
#      from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        run_locally("rake assets:clean && rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      #else
        #logger.info "Skipping asset precompilation because there were no asset changes"
      #end
    end

    task :symlink, :roles => :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end
  
  task :copy_git_ignored_files do
    
    # since config/private.yml and config/database.yml are in .gitignore
    # create the directory #{shared_path}/local_config and populate with your own YML files
    
    begin
      run "cp #{shared_path}/local_config/*.yml #{current_path}/config"
    rescue Exception
      puts "\nCOPY OF SHARED database.yml AND/OR private.yml FAILED - CHECK THEY EXIST\n\n"
    end
  end
  
  task :restart_passenger do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :restart do
    run "#{deploy_to}/bin/restart" 
  end
end
