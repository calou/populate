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
		    p1 varchar(30),
		    p2 Date
		  );
			SQL
	end

	@connection = double()
	Klass.stubs(:connection).returns(@connection)

  end
  after(:all) do
  	File.delete(conf[:database])
  end
  it 'should trigger connection.execute' do
  	puts Klass.new.attributes.inspect
    Klass.connection.should_receive(:execute)
  	Klass.populate({:p1 => "Value", :p2 => Date.new(2000, 5, 17)})
  end
end
