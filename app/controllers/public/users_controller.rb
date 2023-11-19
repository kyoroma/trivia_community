class Public::UsersController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_my_page_path, notice: '登録情報が更新されました。'
    else
      render :edit
    end
  end

  def confirm_deactivation
  end

  def deactivation
    current_user.update(status: 'inactive')
    sign_out(current_user)
    redirect_to root_path, notice: '退会が完了しました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
