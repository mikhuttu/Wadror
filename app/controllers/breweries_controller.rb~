class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy, :toggle_activity]
  before_action :ensure_that_signed_in, except: [:index, :show, :nglist]
  before_action :ensure_that_admin, only: [:destroy]

  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired

    order = params[:order] || 'name'

    if order == 'name'
      @active_breweries = @active_breweries.sort_by{ |b| b.name }
      @retired_breweries = @retired_breweries.sort_by{ |b| b.name }
      
      if session[:breweries_order] == 'name' # viimeksi kun käytiin sivulla, järjestettiin panimot nimen mukaan
        if params[:order] # metodiin tultiin käymällä klikkaamassa breweries -sivulla 'Name' kenttää (eikä jostain muulta sivulta)
          reverse_order
        end
      else
        update_breweries_order(order)
      end

    elsif order == 'year'
      @active_breweries = @active_breweries.sort_by{ |b| b.year }
      @retired_breweries = @retired_breweries.sort_by{ |b| b.year }

      if session[:breweries_order] == 'year'      
        reverse_order
      else
        update_breweries_order(order)
      end
    end
  end

 
  def show
  end


  def new
    @brewery = Brewery.new
  end

 
  def edit
  end

  def nglist
  end

  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    @brewery.update_attribute :active, (not @brewery.active)

    new_status = @brewery.active? ? "active" : "retired"
    redirect_to :back, notice:"Brewery activity status changed to #{new_status}."
  end


  private
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end

    def update_breweries_order(order)
      session[:breweries_order] = order
    end

    def reverse_order
      session[:breweries_order] = nil
      @active_breweries.reverse!
      @retired_breweries.reverse!
    end
end
