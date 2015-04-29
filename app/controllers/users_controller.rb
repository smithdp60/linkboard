class UsersController < ApplicationController

  # signup (GET)
  def new
  end

  # create the user (POST)
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Sign Up Successful"
      redirect_to login_path
    else
      flash[:danger] = "Invalid Credentials"
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end

