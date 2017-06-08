class UsersController < ApplicationController

  # get new users signup
  def new
  end

  # post new users
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user_id
      redirect to '/'
    else
      redirect_to '/signup'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
