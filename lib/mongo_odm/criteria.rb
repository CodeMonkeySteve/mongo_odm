# encoding: utf-8
module MongoODM

  class Criteria
    delegate :to_a, :count, :collect, :map, :each, :all?, :include?, :to => :to_cursor
    delegate :to_xml, :to_yaml, :to_json, :include?, :length, :to => :to_a

    def initialize(klass, options = {})
      @klass    = klass
      @selector = options[:selector] || {}
      @opts     = options[:opts]     || {}
      @sort     = options[:sort]     || []
      @limit    = options[:limit]    || nil
      @skip     = options[:skip]     || nil
      reload
    end

    def ==(other)
      case other
      when Criteria
        other.instance_variable_get(:@selector) == @selector &&
        other.instance_variable_get(:@opts)     == @opts     &&
        other.instance_variable_get(:@sort)     == @sort    &&
        other.instance_variable_get(:@limit)    == @limit    &&
        other.instance_variable_get(:@skip)     == @skip
      else
        to_a == other.to_a
      end
    end

    def to_cursor
      if @cursor
        @cursor.rewind!
      else
        @cursor = @klass.collection.find(@selector, @opts)
        @cursor = @cursor.sort(@sort)   unless @sort.blank?
        @cursor = @cursor.limit(@limit) unless @limit.blank?
        @cursor = @cursor.skip(@skip)   unless @skip.blank?
      end
      @cursor
    end

    def reload
      @cursor = nil
      self
    end

    def _merge_criteria(criteria)
      @selector.merge!(criteria.instance_variable_get(:@selector))
      @opts.merge!(criteria.instance_variable_get(:@opts))
      @sort  << criteria.instance_variable_get(:@sort) unless criteria.instance_variable_get(:@sort).blank?
      @limit = criteria.instance_variable_get(:@limit) unless criteria.instance_variable_get(:@limit).blank?
      @skip  = criteria.instance_variable_get(:@skip)  unless criteria.instance_variable_get(:@skip).blank?
      reload
    end

    def method_missing(method_name, *args, &block)
      if @klass.respond_to?(method_name)
        result = @klass.send(method_name, *args, &block)
        result.is_a?(Criteria) ? _merge_criteria(result) : result
      elsif (cursor = to_cursor).respond_to?(method_name)
        cursor.send(method_name, *args, &block)
      elsif [].respond_to?(method_name)
        to_a.send(method_name, *args, &block)
      else
        super
      end
    end

  end

end