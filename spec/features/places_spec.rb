require 'rails_helper'

describe "Places" do
  before :each do
    Rails.cache.clear
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are shown at the page" do
    kisko  

    visit places_path
    fill_in('city', with: 'kisko')
    click_button "Search"

    expect(page).to have_content "Kiskon Olut"
    expect(page).to have_content "Kiskon Grilli"
    expect(page).to have_content "Kiskon Baari"
  end

  it "if none are returned by the API, notice is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("salo").and_return(
      []
    )
     
    visit places_path
    fill_in('city', with: 'salo')
    click_button "Search"

    expect(page).to have_content "No locations in salo"
  end

end # describe Places

def kisko
  allow(BeermappingApi).to receive(:places_in).with("kisko").and_return(
    [ Place.new( name:"Kiskon Olut", id: 1 ),
      Place.new( name:"Kiskon Grilli", id: 2 ),
      Place.new( name:"Kiskon Baari", id: 3 ) ]
  )
end


