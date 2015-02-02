require 'rails_helper'

RSpec.describe User, :type => :model do
  
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)	# expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with invalid password" do
    let(:user) { User.create username:"Pekka", password"a1B", password_confirmation:"a1B" } 

    it "is not saved"
      user = User.create username:"Pekka", password"a1B", password_confirmation:"a1B"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  
  end

  describe "with a proper password" do
    let(:user) { User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user.valid?).to be(true)	# expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      r = Rating.new score:10
      r2 = Rating.new score:13
      user.ratings << r1
      user.ratings << r2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(11.5)
    end
  end

end
