class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
  end

  def quit
  end
  
  def withdraw
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :user_icon)
  end
  
end
