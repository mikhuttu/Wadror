class SessionsController < ApplicationController
  def new
    if not current_user.nil?
      redirect_to '/', notice: "You're already signed in."
    end
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/" # :root doesn't work
  end

end
