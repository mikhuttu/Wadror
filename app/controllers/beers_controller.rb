class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :ensure_that_admin, only: [:destroy]
  before_action :clear_beerlist_from_cache, only: [:create, :update, :destroy]
  before_action :skip_if_cached, only: [:index]

  def index
    @beers = Beer.includes(:brewery, :style).all
    order = params[:order] || 'name'

    @beers = case order
      when 'name' then @beers.sort_by{ |b| b.name }
      when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
      when 'style' then @beers.sort_by{ |b| b.style.name }
    end
  end

  def show
    @rating = Rating.new
    @rating.beer = @beer
  end


  def new
    @beer = Beer.new
  end


  def edit
  end

  def list
  end

  def nglist
  end


  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: beers_path }
      else
        set_breweries_and_styles_for_template

        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        set_breweries_and_styles_for_template
        
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clear_beerlist_from_cache
    ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) }
  end

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{@order}"  )
  end

  private

    def set_beer
      @beer = Beer.find(params[:id])
    end

    def set_breweries_and_styles_for_template
      @breweries = Brewery.all
      @styles = Style.all
    end


    def beer_params
      params.require(:beer).permit(:name, :style_id, :brewery_id)
    end
end
