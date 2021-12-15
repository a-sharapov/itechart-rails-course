require 'rails_helper'

RSpec.describe Static, type: :model do
  context "validation tests" do
    it "ensures static title is present" do
      static = Static.new(introtext: "Test content")
      expect(static.valid?).to eq(false)
    end
    it "should be able to save static" do
      static = Static.new(title: "Test content")
      expect(static.save).to eq(true)
    end
  end

  context "creation tests" do
    let(:test_params) {
      {title: "Test title", introtext: "Test introtext", content: "Test content"}
    }
    before(:each) do 
      3.times do
        Static.create(test_params)
      end
    end
    it "should be created static" do
      expect(Static.count).to eq(3)
    end
  end
  
  context "scope tests" do
  end
end