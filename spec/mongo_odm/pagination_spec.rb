# encoding: utf-8
require "spec_helper"

describe MongoODM::Pagination do
  before do
    @docs = (1..5).map { |n|  shape = Shape.new( :x => n, :y => n ) ; shape.save ; shape }
  end

  it '#paginate' do
    Shape.find.paginate( :per_page => 2 ).should == @docs[0,2]
    Shape.find.paginate( :page => 1, :per_page => 2 ).should == @docs[0,2]
    Shape.find.paginate( :page => 2, :per_page => 2 ).should == @docs[2,2]
    Shape.find.paginate( :page => 3, :per_page => 2 ).should == @docs[4,1]
  end
end
