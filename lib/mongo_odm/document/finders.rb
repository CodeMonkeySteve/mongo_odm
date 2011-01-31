module MongoODM
  module Document
    module Finders

      extend ActiveSupport::Concern

      module ClassMethods
        def where( *args )
          MongoODM::Criteria.new(self, *args)
        end

        def find( *args )
          if (args.size == 1) && (criteria = find_one_by_id(args.first))
            criteria.first
          elsif (criteria = find_many_by_ids(args))
            criteria
          else
            where(*args)
          end
        end

        def find!( *ids )
          documents = Array( find(*ids) )
          found = documents.map(&:id)
          missing = ids.reject { |id|  found.include?(id) }
          missing.empty?  or raise Errors::DocumentNotFound.new(self.class, missing)
          (documents.count == 1) ? documents.first : documents
        end

        def find_or_initialize_by( attr )
          self.find(attr).first || self.new(attr)
        end

        def find_or_create_by( attr )
          doc = find_or_initialize_by(attr)
          doc.save  if doc.new_record?
          doc
        end

      protected
        def find_one_by_id( id )
          unless id.kind_of? BSON::ObjectId
            begin
              id = BSON::ObjectId.from_string(id)
            rescue BSON::InvalidObjectId
              return nil
            end
          end
          self.where( :_id => id )
        end

        def find_many_by_ids( ids )
          ids = ids.map  do |id|
            if id.kind_of?(BSON::ObjectId)
              id
            else
              begin
                BSON::ObjectId.from_string(id)
              rescue BSON::InvalidObjectId
                return nil
              end
            end
          end
          self.where( :_id => { :$in => ids } )
        end
      end
    end
  end
end