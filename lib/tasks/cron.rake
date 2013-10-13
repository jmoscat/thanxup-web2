#RAILS_ENV=production rake daily
task :daily => :environment do
  Stat.daily
end