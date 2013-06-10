require 'spec_helper'

describe Populate do
  it 'should create database entries' do
    puts Database::PROPERTIES[:file]
    lambda {
  		DummyClass.populate([{:p1 => "Value' # `", :p2 => Date.new(2010, 6, 3)},{:p1 => "Value", :p2 => Date.new(2000, 5, 17)}])
  	}.should change(DummyClass, :count).by(2)
  end

  it 'should set created_at and updated_at if exist' do
    TimestampDummyClass.delete_all
    now = Time.now.utc + 5.minutes
    Time.stub(:now).and_return now
    TimestampDummyClass.populate([{:p1 => "Value' # `", :p2 => Date.new(2010, 6, 3)},{:p1 => "Value", :p2 => Date.new(2000, 5, 17)}])
    TimestampDummyClass.all.each do |tdc| 
      tdc.created_at.to_i.should == now.to_i
      tdc.updated_at.to_i.should == now.to_i
    end
  end
end
