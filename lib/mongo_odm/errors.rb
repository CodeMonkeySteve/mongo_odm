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

    class DocumentNotFound < Error
      attr_reader :klass, :ids
      def initialize( klass, ids )
        @klass, @ids = klass, Array(ids)
      end
    end
  end

end
