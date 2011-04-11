# encoding: utf-8
require "spec_helper"

describe MongoODM::Criteria do
  before do
    @shapes = %w(red green blue).map { |c|  Shape.new(:color => c).save }
  end

  it "#first" do
    criteria = Shape.where(:color => 'red')
    criteria.should be_a(MongoODM::Criteria)
p criteria.first
    criteria.first.should == @shapes.first
  end

  it "#sort" do
    Shape.find.sort(:color).first.should == @shapes.last
  end
end