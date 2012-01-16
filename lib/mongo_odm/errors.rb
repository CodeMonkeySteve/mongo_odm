# encoding: utf-8
module MongoODM
  class Error < StandardError
  end

  module Errors
    class TypeCastMissing < Error
      def initialize(value, klass)
        super "can't convert #{value.inspect} to #{klass}: Define a `type_cast' method for #{value.class}:#{value.class.class}"
      end
    end

    class InvalidLocalizedField < Error
      def initialize(field_name, klass)
        super "can't localize field #{field_name}; it has to be declared as a Hash, was #{klass}"
      end
    end

    class UnknownFieldError < Error
      def initialize(field_name, klass)
        super "unknown field #{field_name} on class #{klass.name}"
      end
    end

    class DocumentNotFound < Error
      def initialize(ids, klass)
        super "can't find document for class #{klass} with id(s) #{ids}"
      end
    end

    class Validation < Error
      def initialize(doc)
        super "validation failure: #{doc.errors.full_messages}"
      end
    end

    class ReferenceNewRecord < Error
      def initialize
        super "can't reference new record"
      end
    end
  end
end
