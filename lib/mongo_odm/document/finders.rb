module MongoODM
  module Document
    module Finders

      extend ActiveSupport::Concern

      module ClassMethods
        def where(selector = {}, opts = {})
          MongoODM::Criteria.new(self, :selector => selector, :opts => opts)
        end

        def find(*args)
          if (args.size == 1) && (criteria = find_one_by_id(args.first))
            criteria.first
          elsif (args.size >= 2) && (criteria = find_many_by_ids(args))
            criteria
          else
            where(*args)
          end
        end

        def find!(*ids)
          documents = Array(find(*ids))
          found = documents.map(&:id)
          missing = ids.reject { |id|  found.include?(id) }
          missing.empty?  or raise Errors::DocumentNotFound.new(self.class, missing)
          (documents.count == 1) ? documents.first : documents
        end

        def find_or_initialize_by(attr)
          self.find(attr).first || self.new(attr)
        end

        def find_or_create_by(attr)
          doc = find_or_initialize_by(attr)
          doc.save if doc.new_record?
          doc
        end

        def sort(key_or_list, direction = nil)
          order = key_or_list.is_a?(Array) ? key_or_list : direction.nil? ? [key_or_list, :asc] : [key_or_list, direction]
          MongoODM::Criteria.new(self, :sort => order)
        end

        def skip(number_to_skip = nil)
          MongoODM::Criteria.new(self, :skip => number_to_skip)
        end

        def limit(number_to_return = nil)
          MongoODM::Criteria.new(self, :limit => number_to_return)
        end

        def to_cursor
          if @cursor
            @cursor.rewind!
          else
            @cursor = where.to_cursor
          end
          @cursor
        end

        def method_missing(method_name, *args, &block)
          if (cursor = to_cursor).respond_to?(method_name)
            cursor.send(method_name, *args, &block)
          else
            super
          end
        end

      protected
        def find_one_by_id(id)
          return nil if id.kind_of?(Hash)
          unless id.kind_of? BSON::ObjectId
            begin
              id = BSON::ObjectId.from_string(id.to_s)
            rescue BSON::InvalidObjectId
              return nil
            end
          end
          self.where(:_id => id)
        end

        def find_many_by_ids(ids)
          return nil if ids.any? { |id|  id.kind_of?(Hash) }
          ids = ids.map  do |id|
            if id.kind_of?(BSON::ObjectId)
              id
            else
              begin
                BSON::ObjectId.from_string(id.to_s)
              rescue BSON::InvalidObjectId
                return nil
              end
            end
          end.compact
          ids.present? && self.where(:_id => { :$in => ids })
        end
      end
    end
  end
end