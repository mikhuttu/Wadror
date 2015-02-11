require 'rails_helper'

describe "Beer" do
  before :each do
    FactoryGirl.create :brewery, name:"Koff", year: 1857
    FactoryGirl.create :style

    FactoryGirl.create :user
    sign_in(username: "Pekka", password: "Foobar1", password_confirmation: "Foobar1")
  end
   
  it "can be added to DB with valid name, style and brewery" do
    visit new_beer_path

    fill_in('beer[name]', with:'olut')
    select('Euro Pale Ale', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "adding doesn't work without a name" do
    visit new_beer_path    

    fill_in('beer[name]', with:'')
    select('Euro Pale Ale', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(current_path).to eq(beers_path)
    expect(page).to have_content 'New Beer'
    expect(page).to have_content 'Name is too short'
  end

end
