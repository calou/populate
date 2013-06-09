require "populate/version"
require "populator"

module Populate
  def self.included(base)
      base.extend(ClassMethods)
  end

  module ClassMethods
    def populate array, batch_size = 512
      populator = Populator.new self, array      
	  	populator.execute batch_size
		end
  end
end
