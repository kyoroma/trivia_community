class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @post, notice: 'コメントが投稿されました。'
    else
      render :new
    end
  end

  def index
    @comments = Comment.all
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
