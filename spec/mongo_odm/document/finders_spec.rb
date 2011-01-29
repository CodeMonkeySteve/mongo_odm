# encoding: utf-8
require 'spec_helper'

describe MongoODM::Document::Finders do
  before do
    @shapes = %w(red green blue).map { |color|  shape = Shape.new(:color => color) ; shape.save ; shape }
  end

  describe "#find" do
    it "finds one by id" do
      Shape.find(@shapes.first.id).should == @shapes.first
    end

    it "finds multiple by ids" do
      Shape.find( *@shapes.map(&:id) ).should == @shapes
    end

    it "finds by criteria" do
      Shape.find( :color => @shapes.last.color ).should == [@shapes.last]
    end
  end
end