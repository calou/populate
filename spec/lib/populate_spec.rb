require 'spec_helper'


conf = {
  adapter:  'sqlite3',
  database: 'test.sqlite3'
}

describe Populate do
  before(:all) do
	
  	SQLite3::Database.new(conf[:database]) do |db|
  		rows = db.execute <<-SQL
  		  create table klasses (
          id integer,
  		    p1 varchar(30),
  		    p2 Date
  		  );
  			SQL
  	end
  end

  after(:all) do
  	File.delete(conf[:database])
  end
  it 'should create database entries' do
  	lambda {
  		Klass.populate([{:p1 => "Value' # `", :p2 => Date.new(2010, 6, 3)},{:p1 => "Value", :p2 => Date.new(2000, 5, 17)}])
  	}.should change(Klass, :count).by(2)
  end
end
