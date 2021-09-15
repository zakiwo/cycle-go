class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nick_name, :introduction, :is_deleted)
  end
end
