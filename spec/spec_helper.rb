require 'populate'
require 'active_record'
require 'sqlite3'
require 'dummy_classes'

class Database
  PROPERTIES = {
    adapter:  'sqlite3',
    database: File.expand_path("test.sqlite3", File.dirname(__FILE__))
  }
  def self.create
    SQLite3::Database.new(PROPERTIES[:database]) do |db|
      db.execute <<-SQL
        create table dummy_classes (
          id int(11),
          p1 varchar(30),
          p2 date
        );
      SQL
      db.execute <<-SQL
        create table timestamp_dummy_classes (
          id int(11),
          p1 varchar(30),
          p2 date,
          created_at datetime,
          updated_at datetime
        );
      
      SQL
    end
    ActiveRecord::Base.establish_connection PROPERTIES
  end

  def self.delete
    File.delete(PROPERTIES[:database])
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    Database.create
  end
  config.after(:suite) do 
    Database.delete
  end
end

 


