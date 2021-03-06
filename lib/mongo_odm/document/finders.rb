module MongoODM
  module Document
    module Finders

      extend ActiveSupport::Concern

      module ClassMethods
        delegate :sort, :skip, :limit, :to => :where

        def where(selector = {}, opts = {})
          MongoODM::Criteria.new(self, selector, opts)
        end
        alias all where

        def find(*args)
          if (args.size == 1) && (criteria = find_one_by_id(args.first))
            criteria.first
          elsif (args.size == 1) && args[0].is_a?(Array) && (criteria = find_many_by_ids(args[0]))
            criteria
          elsif (args.size >= 2) && (criteria = find_many_by_ids(args))
            criteria
          else
            where(*args)
          end
        end

        def find!(*ids)
          ids.map! { |id| id.is_a?(BSON::ObjectId) ? id : BSON::ObjectId(id) }
          documents = Array(find(*ids))
          found = documents.map(&:id)
          missing = ids.reject { |id|  found.include?(id) }
          missing.empty? or raise Errors::DocumentNotFound.new(missing, self.class)
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

        def method_missing(method_name, *args, &block)
          if (criteria = self.where).respond_to?(method_name)
            criteria.send(method_name, *args, &block)
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
          self.where(:_id => { :$in => ids })
        end
      end
    end
  end
end
