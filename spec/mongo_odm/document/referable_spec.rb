# encoding: utf-8
require "spec_helper"

describe MongoODM::Document::Referable do
  it "#to_dbref" do
    dbref = Shape.new.save.to_dbref
    dbref.should be_a(BSON::DBRef)
    dbref.namespace.should == Shape.collection.name
    dbref.object_id.should be_a(BSON::ObjectId)
  end
end