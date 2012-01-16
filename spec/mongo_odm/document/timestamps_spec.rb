# encoding: utf-8
require "spec_helper"

describe MongoODM::Document::Timestamps do
  class TimestampedShape < Shape
    include MongoODM::Document::Timestamps
  end

  it "serializes" do
    now = Time.now
    Time.stub!(:now).and_return(now)

    shape = TimestampedShape.new.save!
    shape.created_at.should == shape.updated_at
    shape.created_at.should be_within(0.001).of(now)
    Shape.find(shape.id).should == shape
  end
end