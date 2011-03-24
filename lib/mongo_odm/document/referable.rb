# encoding: utf-8

module MongoODM
  autoload :Reference

  module Document
    module Referable
      extend ActiveSupport::Concern

      module ClassMethods
        def referenced_in(model, field = nil, opts = {})
          model = model.to_s.camelize.constantize

          n = self.name.underscore
          field_name = field ||
            (model.fields.include?(f = n.singularize.to_sym) && f) ||
            (model.fields.include?(f = n.pluralize.to_sym) && f)
          raise "Missing field" unless field_name
          raise(UnknownFieldError, field_name, model) unless model.fields.include?(field_name)

          method_name = opts[:as] || model.to_s.underscore.pluralize
          raise "Field \"#{method_name}\" already defined in #{self.name}" if method_defined?(method_name.to_sym)

          self.class_eval <<-EOT
            def #{method_name}
              #{model}.where('#{field_name}' => self.to_dbref )
            end
          EOT
        end
      end

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
