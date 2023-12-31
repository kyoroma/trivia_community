class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_guest, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @comments = @user.comments
    @favorites = @user.favorites.includes(:post) # お気に入りに登録した投稿を取得
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  def my_page
    @user = current_user
    @favorites = @user.favorites.includes(post: [:genre, :tags]).order(created_at: :desc)
  end

  def confirm_deactivation
    # ゲストユーザーの場合は退会の確認画面を表示しない
    redirect_to root_path if current_user.guest?
  end

  def deactivation
    # ゲストユーザーの場合は退会処理を実行せず、トップページへリダイレクト
    return redirect_to root_path if current_user.guest?

    current_user.update(is_active: false)
    sign_out(current_user)
    redirect_to root_path, notice: '退会が完了しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_guest
    if current_user && current_user.guest?
      flash[:alert] = "ゲストユーザーの情報は編集できません。"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
