require 'populate'
require 'active_record'
require 'sqlite3'
require 'rspec/mocks'


conf = {
  adapter:  'sqlite3',
  database: 'test.sqlite3'
}
 
ActiveRecord::Base.establish_connection conf



class Klass < ActiveRecord::Base 
  include Populate      
end