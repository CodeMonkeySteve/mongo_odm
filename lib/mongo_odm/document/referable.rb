# encoding: utf-8

module MongoODM
  autoload :Reference

  module Document
    module Referable
      extend ActiveSupport::Concern

      module InstanceMethods
        def to_dbref
          BSON::DBRef.new(self.class.collection.name, _id)
        end
      end
    end
  end
end
