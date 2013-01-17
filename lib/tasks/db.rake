namespace :db do
  desc 'Remove and install new database from scratch'
  task :install => :environment do
    puts "Clearing Redis"
    Redis.current.flushdb

    puts "Droping all tables..."
    root   = File.expand_path('../../../app/models/', __FILE__)
    models = Dir["#{root}/**"].each{|x| require x; }
    tables = ActiveRecord::Base.connection.tables

    ActiveRecord::Base.connection.drop_table "schema_migrations"

    ActiveRecord::Base.subclasses.map{|x| x.table_name}.each do |x|
      ActiveRecord::Base.connection.drop_table x if tables.include? x
      puts "#{x} droped;"
    end
    puts

    puts "Running migrations..."
    Rake::Task["db:migrate"].invoke

    puts "Running seeds..."
    Rake::Task["db:seed"].invoke
  end
end