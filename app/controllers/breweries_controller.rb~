class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:destroy]


  def index
    @breweries = Brewery.all
  end

 
  def show
  end


  def new
    @brewery = Brewery.new
  end

 
  def edit
  end


  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if validate_year and @brewery.save
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

  private
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    def validate_year
      if not @brewery.year.nil? and @brewery.year <= Time.now.year
        true
      elsif @brewery.year.nil?
        @brewery.errors.add(:year, "cannot be null.")
        false
      else
        @brewery.errors.add(:year, "not valid.")
        false
      end
    end
    

    def brewery_params
      params.require(:brewery).permit(:name, :year)
    end

    def authenticate
      admin_accounts = { "admin" => "secret", "pekka" => "beer", "arto" => "foobar"}
   
      authenticate_or_request_with_http_basic do |username, password|
        admin_accounts.has_key?(username) && admin_accounts[username] == password
      end
    end
end
