# encoding: utf-8
require "spec_helper"

describe MongoODM::Document::Persistence do
  describe "#save" do
    it "saves a document" do
      shape = Shape.new(:color => 'magenta')
      shape.save.should == shape
      shape.id.should_not be_nil
    end
  end

  describe "#save!" do
    class TestDocument < Shape
      validates_presence_of :color
    end

    it "saves a document" do
      doc = TestDocument.new :color => 'blue'
      doc.should be_valid
      proc { doc.save! }.should_not raise_error(MongoODM::Errors::Validation)
    end

    it "raises error on invalid document" do
      doc = TestDocument.new :color => nil
      doc.should_not be_valid
      proc { doc.save! }.should raise_error(MongoODM::Errors::Validation)
    end
  end
end