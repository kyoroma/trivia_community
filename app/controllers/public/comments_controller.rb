class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.commentable = @post

    if user_signed_in? # ユーザーがサインインしているかどうかを確認
      @comment.user = current_user
    else
      # ゲストユーザーの場合、適切な処理を追加
      # 例: ゲストユーザーに紐づくダミーユーザーを作成してコメントに紐づける
      guest_user = User.create(name: 'Guest User', email: 'guest@example.com')
      @comment.user = guest_user
    end

    if @comment.save
      #puts @comment.errors.full_messages
      redirect_to @post, notice: 'コメントが投稿されました。'
    else
      Rails.logger.error "Comment creation failed: #{@comment.errors.full_messages}"
      redirect_to @post, alert: 'コメントの投稿に失敗しました。'
    end
  end

  def index
    @comments = Comment.all
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id)
  end

end
