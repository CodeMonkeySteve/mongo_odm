# encoding: utf-8
require 'mongo_odm/core_ext/hash_recursive_merge'

module MongoODM

  class Criteria
    delegate :to_xml, :to_yaml, :to_json, :include?, :first, :length, :collect, :map, :all?, :include?, :to => :to_a
    delegate :count, :each, :to => :to_cursor

    def initialize(klass, selector = {}, opts = {})
      @_klass    = klass
      @_selector = selector.to_mongo
      @_opts     = opts
      _set_cursor
    end
    attr_reader :_klass, :_selector, :_opts

    def ==(other)
      case other
      when Criteria
        other._klass    == @_klass &&
        other._selector == @_selector &&
        other._opts     == @_opts
      else
        to_a == other.to_a
      end
    end

    def reload
      @_cursor = nil
      _set_cursor
      self
    end

    def to_a
      @_result ||= @_cursor.rewind! && @_cursor.to_a
    end

    def to_cursor
      @_cursor
    end

    def _set_cursor
      @_cursor ||= @_klass.collection.find(@_selector, @_opts.dup)
    end

    def _merge_criteria(criteria)
      @_selector.rmerge!(criteria._selector.to_mongo)
      @_opts.rmerge!(criteria._opts)
      reload
      self
    end

    def method_missing(method_name, *args, &block)
      if @_klass.respond_to?(method_name)
        result = @_klass.send(method_name, *args, &block)
        result.is_a?(Criteria) ? _merge_criteria(result) : result
      elsif @_cursor.respond_to?(method_name)
        @_cursor.send(method_name, *args, &block)
      elsif [].respond_to?(method_name)
        to_a.send(method_name, *args, &block)
      else
        super
      end
    end

  end

end
