# encoding: utf-8
require 'mongo_odm/core_ext/hash_recursive_merge'

module MongoODM

  class Criteria
    delegate :to_xml, :to_yaml, :to_json, :include?, :length, :collect, :map, :all?, :include?, :to => :to_a
    delegate :count, :each, :to => :cursor

    def initialize(klass, selector = {}, opts = {})
      @_klass    = klass
      @_selector = selector.to_mongo
      @_opts     = opts
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

    def sort(key_or_list, direction = nil)
      @_opts[:sort] = key_or_list.is_a?(Array) ? key_or_list : direction.nil? ? [key_or_list, :asc] : [key_or_list, direction]
      reload
    end

    def skip(number_to_skip = nil)
      @_opts[:skip] = number_to_skip
      reload
    end

    def limit(number_to_return = nil)
      @_opts[:limit] = number_to_return
      reload
    end

    def reload
      @_cursor = nil
      self
    end

    def first
      @_klass.collection.find_one(@_selector, @_opts)
    end

    def to_a
      @_result ||= cursor.rewind! && cursor.to_a
    end

    def cursor
      @_cursor ||= @_klass.collection.find(@_selector, @_opts)
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
      elsif cursor.respond_to?(method_name)
        cursor.send(method_name, *args, &block)
      elsif [].respond_to?(method_name)
        to_a.send(method_name, *args, &block)
      else
        super
      end
    end

  end

end
