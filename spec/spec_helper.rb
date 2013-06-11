require 'populate'
require 'database'
require 'dummy_classes'



RSpec.configure do |config|
  config.before(:suite) do
    Database.create
  end
  config.after(:suite) do 
    Database.delete
  end
end

 


