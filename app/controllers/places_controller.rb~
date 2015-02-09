class PlacesController < ApplicationController
  def index
  end

  def show
    places = BeermappingApi.places_in(session[:city])
    # etsi paikka id:n (params[:id]) perusteella places -taulukosta ja renderöi sivu
        
    places.each do |place|
      if place.id == params[:id]
        @place = place
      end
    end

    if @place.nil?
      redirect_to "/", notice: "You have to search for the pub first."
    end

  end

  def search
    @places = BeermappingApi.places_in(params[:city])

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index
    end
  end

end
