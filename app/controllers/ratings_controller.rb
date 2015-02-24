class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, only: [:create]
  before_action :ensure_that_signed_in, only: [:destroy]
  
  def index
    if session[:ratings_page].nil?	# ladataan arvot välimuistiin ja pidetään niitä siellä 10min. kunnes seuraavalla sivun latauskerralla ladataan uudestaan
      session[:ratings_page] = true
      read_from_database_to_cache
      sleep_and_clear_cache
    end

    @top_beers = Rails.cache.read "beer top 3"
    @top_breweries = Rails.cache.read "brewery top 3"
    @top_styles = Rails.cache.read "style top 3"
    @most_active_users = Rails.cache.read "active users top 3"
    @recent_ratings = Rails.cache.read "recent ratings"
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
        
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user or current_user.admin
    redirect_to :back
  end

  def read_from_database_to_cache
    Rails.cache.write("beer top 3", Beer.top(3))
    Rails.cache.write("brewery top 3", Brewery.top(3))
    Rails.cache.write("style top 3", Style.top(3))
    Rails.cache.write("active users top 3", User.top(3))
    Rails.cache.write("recent ratings", Rating.recent)
  end

  def sleep_and_clear_cache
#    sleep 10.minutes			 kommentoitu yli sillä suoritus "tyssää" tähän WEBrickiä käyttäen
    session[:ratings_page] = nil
  end
end
