require "populate/version"

module Populate
  

    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def populate array
 
		  	self.class.connection.execute('')

		end
    end
end
