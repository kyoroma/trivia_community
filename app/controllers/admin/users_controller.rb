class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.comments
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @comments = @user.comments
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_active)
  end
end
