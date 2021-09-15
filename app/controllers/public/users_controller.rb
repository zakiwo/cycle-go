class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理が完了しました。またのご利用お待ちしています。'
    redirect_to root_path
  end

  private
  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nick_name, :introduction)
  end
end
