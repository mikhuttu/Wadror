require 'rails_helper'

describe "Beer" do
  it "can be added to DB with a valid name" do
    visit new_beer_path    
    fill_in('beer[name]', with:'olut')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "adding doesn't work without a name" do
    visit new_beer_path    
    fill_in('beer[name]', with:'')

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(current_path).to eq(beers_path)
    expect(page).to have_content 'Name is too short'
  end

end
