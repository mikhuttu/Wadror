require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "are shown in the ratings -page" do
    r1 = FactoryGirl.create :rating, score:13, beer:beer1 
    r2 = FactoryGirl.create :rating, score:16, beer:beer2
    
    user.ratings << r1
    user.ratings << r2

    visit ratings_path

    expect(page).to have_content 'Number of ratings: 2'
    expect(page).to have_content user.name
    expect(page).to have_content beer.name
  end

end
