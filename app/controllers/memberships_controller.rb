class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, only: [:destroy]

  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    if current_user.nil?
      redirect_to signin_path, notice: "You must be logged in to join a club."
    else
      @membership = Membership.new
      @beer_clubs = clubs_not_joined
    end
  end

  def edit
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.beer_club, notice: current_user.username + ', welcome to the club!' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    club = @membership.beer_club.name

    @membership.destroy if current_user == @membership.user or current_user.admin
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Membership in ' + club + ' ended.' }
      format.json { head :no_content }
    end
  end

  private
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def clubs_not_joined
      @beer_clubs = BeerClub.all.reject { |club| current_user.beer_clubs.include?(club) }
    end

    def membership_params
      params.require(:membership).permit(:beer_club_id)
    end
end
