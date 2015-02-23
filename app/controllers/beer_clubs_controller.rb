class BeerClubsController < ApplicationController
  before_action :set_beer_club, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_admin, only: [:destroy]

  def index
    @beer_clubs = BeerClub.all
  end

  def show
    set_membership
    @confirmed_members = confirmed_members
    @applied_members = applied_members
  end

  def new
    @beer_club = BeerClub.new
  end

  def edit
  end

  def create
    @beer_club = BeerClub.new(beer_club_params)

    respond_to do |format|
      if @beer_club.save
        new_membership
        @membership.user = current_user
        @membership.confirmed = true
        @membership.save

        format.html { redirect_to @beer_club, notice: 'Beer club was successfully created.' }
        format.json { render :show, status: :created, location: @beer_club }
      else
        format.html { render :new }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @beer_club.update(beer_club_params)
        format.html { redirect_to @beer_club, notice: 'Beer club was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer_club }
      else
        format.html { render :edit }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @beer_club.destroy
    respond_to do |format|
      format.html { redirect_to beer_clubs_url, notice: 'Beer club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#  def activate
#    set_membership #membership of current user
#
#    if @membership.confirmed
#      @membership = Membership.find_by(user_id: params[:id], beer_club_id: @beer_club.id)
#      @membership.update_attribute :confirmed, (true)
#
#      redirect_to :back, notice: @membership.user.username + " became a confirmed club member."
#    else
#      redirect_to :back, notice: "You don't have the permission to do this."
#    end
#  end

  private
    def set_beer_club
      @beer_club = BeerClub.find(params[:id])
    end

    def beer_club_params
      params.require(:beer_club).permit(:name, :founded, :city)
    end

    def set_membership

      if current_user and current_user.beer_clubs.include?(@beer_club)
        @membership = Membership.find_by(user_id: current_user.id, beer_club_id: @beer_club.id)
     else
        new_membership
     end
   end

   def new_membership
     @membership = Membership.new
     @membership.beer_club = @beer_club
   end

   def confirmed_members
     members = []
     @beer_club.memberships.each do |ship|
       members << ship.user if ship.confirmed
     end
     members
   end

   def applied_members
     members = []
     @beer_club.memberships.each do |ship|
       members << ship.user if not ship.confirmed
     end
     members
   end
end
