require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "is not saved" do
    
    it "without a password" do
      user = User.create username:"Pekka"
      expect(user.valid?).to be(false)	# expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "if password is too short" do
      user = User.create username:"Pekka", password:"a1B", password_confirmation:"a1B"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  
    it "if password doesn't contain a number" do
      user = User.create username:"Pekka", password:"aBcd", password_confirmation:"aBcd"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved with a proper password" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create :rating, score: 11
      user.ratings << FactoryGirl.create :rating, score: 20

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.5)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }
    let(:style) { FactoryGirl.create(:style) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user, style)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user, style)
      best = create_beer_with_rating(25, user, style)

      expect(user.favorite_beer).to eq(best)
    end
  end

end #RSpec.describe User

def create_beers_with_ratings(*scores, user, style)
  scores.each do |score|
    create_beer_with_rating score, user, style
  end
end

def create_beer_with_rating(score, user, style)
  beer = FactoryGirl.create(:beer, style:style)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end
