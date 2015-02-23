class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_activity]
  before_action :ensure_that_signed_in, only: [:edit, :update, :destroy]
  before_action :ensure_that_admin, only: [:toggle_activity]

  def index
    @users = User.includes(:beers, :ratings).all
  end

  def show
    @ratings = @user.ratings
    @member_of_clubs = member_of_clubs
    @applied_to_clubs = applied_to_clubs
  end

  def new
    @user = User.new
  end

  def edit
    redirect_to "/", notice:'You do not have the permission to edit this.' if not @user == current_user
  end

  def create
    @user = User.new(user_params)
    @user.admin = false
    @user.active = true

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user == current_user
      respond_to do |format|
        if user_params[:username].nil? and @user == current_user and @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to :back
    end
  end

  def destroy
    if @user == current_user
      @user.destroy
      session[:user_id] = nil
    end

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    new_status = true
    new_status = false if @user.active

    @user.update_attribute :active, (new_status)

    if new_status
      redirect_to :back, notice:"User account status changed to active."
    else
      redirect_to :back, notice:"User account status changed to frozen."
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :admin, :active)
    end

    def member_of_clubs
      clubs = []
      @user.memberships.each do |ship|
        clubs << ship.beer_club if ship.confirmed
      end
      clubs
    end

    def applied_to_clubs
      clubs = []
      @user.memberships.each do |ship|
        clubs << ship.beer_club if not ship.confirmed
      end
      clubs
    end
end
