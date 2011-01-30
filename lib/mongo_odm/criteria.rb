# encoding: utf-8
module MongoODM

  class Criteria
    include Pagination

    delegate :to_a, :count, :collect, :map, :each, :all?, :include?, :to => :cursor
    delegate :inspect, :to_xml, :to_yaml, :length, :to => :to_a

    def initialize(klass, selector = {}, opts = {})
      @klass, @selector, @opts = klass, selector, opts
      @cursor = nil
    end

    def find(selector = {}, opts = {})
      _merge_criteria(selector, opts)
      @cursor = nil
    end

    def loaded?
      @cursor
    end

    def ==(other)
      case other
      when Criteria
        other.instance_variable_get("@selector") == @selector &&
        other.instance_variable_get("@opts")     == @opts
      when Array
        to_a == other.to_a
      end
    end

    def method_missing(method_name, *args, &block)
      if Array.method_defined?(method_name)
        to_a.send(method_name, *args, &block)
      elsif @klass.methods.include?(method_name)
        result = @klass.send(method_name, *args, &block)
        if result.is_a?(Criteria)
          selector = result.instance_variable_get("@selector")
          opts = result.instance_variable_get("@opts")
          _merge_criteria(selector, opts)
        else
          result
        end
      else
        cursor.send(method_name, *args)
      end
    end

    def _merge_criteria(selector, opts)
      @selector.merge!(selector)
      @opts.merge!(opts)
      @cursor = nil
      self
    end

  protected
    def cursor
      @cursor ||= @klass.collection.find(@selector, @opts)
    end
  end

end