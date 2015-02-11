require 'rails_helper'

BeerClub
BeerClubsController
MembershipsController

RSpec.describe Beer, :type => :model do
  
  describe "is saved" do
    it "if has a name" do
      beer = FactoryGirl.create :beer
      
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end
  end

  describe "is not saved" do
    
    it "without a name" do
      beer = Beer.create name:""
      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
  end

end
