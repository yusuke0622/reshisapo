class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path
      flash[:success] = "更新しました"
    else
      render :edit
    end
  end

  def quit
    @user = current_user
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :user_icon)
  end
  
end
