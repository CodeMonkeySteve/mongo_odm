# encoding: utf-8
require 'mongo_odm'
require 'will_paginate/collection'

module MongoODM
  module Pagination

    extend ActiveSupport::Concern

    module InstanceMethods
      def paginate( opts )
        page, per_page = (opts[:page] || 1).to_i, opts[:per_page].to_i
        @opts.merge!( :skip => (page - 1) * per_page, :limit => per_page )
        WillPaginate::Collection.create( page, per_page, self.count ) do |pager|
          pager.replace self.cursor.to_a
        end
      end
    end

  end
end
