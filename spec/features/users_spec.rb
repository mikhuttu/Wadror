require 'rails_helper'

describe "User" do
 
  describe "who has signed up" do
    before :each do
      FactoryGirl.create :user
    end

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      sign_up(user_username:'Brian', user_password:'Secret55', 
              user_password_confirmation:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  it "has list of ratings in its page" do
    create_user_breweries_beers_and_ratings
    @user2 = FactoryGirl.create :user, username:"Erkki"

    rat = FactoryGirl.create :rating, score: 30
    @user2.ratings << rat

    visit user_path(@user)

    expect(page).to have_content 'has made 3 ratings'
    expect(page).to have_content 'score: 20'
  end

  describe "if deletes an own rating" do
    before :each do
      create_user_breweries_beers_and_ratings
      sign_in(username:"Pekka", password:"Foobar1")
    end

    it "the rating is removed from DB" do
      visit user_path(@user)

      expect(Rating.count).to eq(3)

      page.find("a[href='/ratings/2']").click

      expect(Rating.count).to eq(2)
      expect(page).to have_content('has made 2 ratings, average: 17.5')
    end
  end

  it "has favorite style and brewery" do
    create_user_breweries_beers_and_ratings
    visit user_path(@user)

    expect(page).to have_content 'Favorite Style: Style1'
    expect(page).to have_content 'Favorite Brewery: Brew1'
  end

end #describe User

def create_user_breweries_beers_and_ratings
  @user = FactoryGirl.create :user
  brew1 = FactoryGirl.create :brewery, name:"Brew1", year:1600
  brew2 = FactoryGirl.create :brewery, name:"Brew2", year:1700

  style1 = FactoryGirl.create :style, name:"Style1"
  style2 = FactoryGirl.create :style, name:"Style2"

  b1 = FactoryGirl.create :beer, name: "Fasu", style: style2, brewery: brew1
  b2 = FactoryGirl.create :beer, name: "Kukko", style: style1, brewery: brew1
  b3 = FactoryGirl.create :beer, name: "Kana", style: style2, brewery: brew2

  r1 = FactoryGirl.create :rating, score: 15, beer: b1
  r2 = FactoryGirl.create :rating, score: 26, beer: b2
  r3 = FactoryGirl.create :rating, score: 20, beer: b3
      
  @user.ratings << r1
  @user.ratings << r2
  @user.ratings << r3
end
