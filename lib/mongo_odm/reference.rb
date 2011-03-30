# encoding: utf-8

module MongoODM
  class Reference
    attr_reader :ref
    alias to_dbref ref

    def initialize(attr = {})
      @ref, @target = case attr
        when Reference    then  [attr.ref, attr.target]
        when BSON::DBRef  then  [attr,     nil]
        when Document     then  [nil,      attr]
        else
          raise "Can only reference object of type Reference, DBRef, or Document, not #{attr.class.inspect}"
      end
    end

    def target
      @target ||= @ref.dereference
    end
    alias dereference target

    def reload
      @target = nil
      self
    end

    # Object instance methods:
    #   :class, :clone, :dup, :enum_for, :instance_exec, :instance_of?, :instance_variable_defined?, :instance_variable_get,
    #   :instance_variable_set, :instance_variables, :method, :methods, :nil?, :object_id, :private_methods, :protected_methods,
    #   :public_method, :public_methods, :public_send, :respond_to_missing?, :singleton_class, :singleton_methods, :taint,
    #   :tainted?, :tap, :to_enum, :trust, :untaint, :untrust, :untrusted?, :equal?

    delegate :!=, :!~, :<=>, :===, :=~, :eql?, :to => :target
    #delegate :inspect, :to_s, :instance_eval, :hash, :is_a?, :kind_of?, :respond_to?, :__send__, :to => :target
    delegate :send, :as_json, :to => :target
    def method_missing(method, *args)
      target.send(method, *args)
    end

    def eql?(that)
      if that.is_a?(BSON::DBRef)
        that.eql?(@ref)
      elsif that.is_a?(Reference)
        that.ref.eql?(@ref)
      elsif that.respond_to?(:to_dbref)
        that.to_dbref.eql?(@ref)
      else
        that.eql?(self)
      end
    end
    alias :== :eql?

    def to_mongo
      @ref ||= @target && @target.to_dbref
    end

    def self.type_cast(value)
      return value if value.is_a?(MongoODM::Reference)
      return MongoODM::Reference.new(value) if value.is_a?(BSON::DBRef)
      return MongoODM::Reference.new(value.to_dbref) if value.respond_to?(:to_dbref)
      nil
    end
  end
end

# Override DBRef to always instantiate as a Reference
class BSON::DBRef
  def self.type_cast(value)
    MongoODM::Reference.type_cast(value)
  end
end
