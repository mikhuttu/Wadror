class MembershipsController < ApplicationController
  before_action :set_membership, only: [:destroy, :activate]
  before_action :ensure_that_signed_in, only: [:new, :create, :destroy, :activate]

#  def index
#    @memberships = Membership.all
#  end

#  def show
#  end

  def new
    @membership = Membership.new
    @beer_clubs = clubs_not_joined
  end

#  def edit
#  end

  def create
    @membership = Membership.new(membership_params)
    @membership.confirmed = false
    @membership.user = current_user

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.beer_club, notice: current_user.username + ', you have joined the club. Please wait for a club member to confirm your membership.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

#  def update
#    respond_to do |format|
#      if @membership.update(membership_params)
#        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
#        format.json { render :show, status: :ok, location: @membership }
#      else
#        format.html { render :edit }
#        format.json { render json: @membership.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def destroy
    club = @membership.beer_club.name

    @membership.destroy if current_user == @membership.user or current_user.admin
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Membership in ' + club + ' ended.' }
      format.json { head :no_content }
    end
  end

  def activate
    current_user_membership = Membership.find_by(user_id: current_user.id, beer_club_id: @membership.beer_club.id)

    if current_user_membership and current_user_membership.confirmed
      @membership.update_attribute :confirmed, (true)
      redirect_to :back, notice: @membership.user.username + " became a confirmed club member."
    
    else
      redirect_to :back, notice: "You don't have the permission to do this."
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
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
