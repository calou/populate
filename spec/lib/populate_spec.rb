require 'spec_helper'

describe Populate do
  it 'should create database entries' do
    puts Database::PROPERTIES[:file]
    lambda {
  		DummyClass.populate([{:p1 => "Value' # `", :p2 => Date.new(2010, 6, 3)},{:p1 => "Value", :p2 => Date.new(2000, 5, 17)}])
  	}.should change(DummyClass, :count).by(2)
  end
end
