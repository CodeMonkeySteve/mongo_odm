# encoding: utf-8

module MongoODM
  autoload :Reference

  module Document
    module Referable
      extend ActiveSupport::Concern

      module InstanceMethods
        Reference = MongoODM::Reference

        def to_dbref
          BSON::DBRef.new(self.class.collection.name, _id)
        end

        def reference
          Reference.new self.to_dbref
        end
        alias ref reference
      end
    end
  end
end
