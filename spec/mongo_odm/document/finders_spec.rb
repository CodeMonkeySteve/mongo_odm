# encoding: utf-8
require 'spec_helper'

describe MongoODM::Document::Finders do
  before do
    @shapes = %w(red green blue).map { |color|  shape = Shape.new(:color => color).save }
  end

  describe "#find" do
    it "returns criteria" do
      shapes = Shape.find
      shapes.should be_kind_of(MongoODM::Criteria)
      shapes.should == @shapes
    end

    it "finds one by id" do
      Shape.find(@shapes.first.id).should == @shapes.first
      Shape.find([@shapes.first.id]).should == [@shapes.first]
    end

    it "finds multiple by ids" do
      Shape.find([]).should == []
      Shape.find(*@shapes.map(&:id)).should == @shapes
      Shape.find(@shapes.map(&:id)).should == @shapes
    end

    it "finds by criteria" do
      Shape.find(:color => @shapes.last.color).should == [@shapes.last]
    end
  end

  describe "#find!" do
    it "returns criteria" do
      Shape.find!.should == @shapes
    end

    it "finds existing document" do
      Shape.find!(@shapes.first.id).should == @shapes.first
    end

    it "errors when document missing" do
      lambda {
        Shape.find!(BSON::ObjectId.new)
      }.should raise_error(MongoODM::Errors::DocumentNotFound)
    end
  end

  describe "#find_or_initialize_by" do
    it "finds existing document" do
      Shape.find_or_initialize_by(:color => @shapes.last.color).should == @shapes.last
    end

    it "initializes new document" do
      color = 'purple'
      shape = Shape.find_or_initialize_by(:color => color)
      shape.color.should == color
      shape.should be_new_record
    end
  end

  describe "#find_or_create_by" do
    it "finds existing document" do
      Shape.find_or_create_by(:color => @shapes.last.color).should == @shapes.last
    end

    it "creates new document" do
      color = 'purple'
      shape = Shape.find_or_create_by(:color => color)
      shape.color.should == color
      shape.should_not be_new_record
    end
  end
end
