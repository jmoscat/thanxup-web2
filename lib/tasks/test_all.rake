task :test_all do
  puts "Recreate the test database"
  Rake::Task['db:test:prepare'].invoke

  RAILS_ENV = 'test' # Force the environment to test

  puts "Seed the database with fixtures"
  Rake::Task['db:fixtures:load'].invoke

  puts "Executing Unit Tests"
  Rake::Task['test:units'].prerequisites.clear 
  Rake::Task['test:units'].invoke

  puts "Executing Functional Tests"
  Rake::Task['test:functionals'].prerequisites.clear 
  Rake::Task['test:functionals'].invoke

  puts "Executing Integration Tests"
  Rake::Task['test:integration'].prerequisites.clear 
  Rake::Task['test:integration'].invoke

end
