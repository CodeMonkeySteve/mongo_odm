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