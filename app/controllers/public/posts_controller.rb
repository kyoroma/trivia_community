class Public::PostsController < ApplicationController
  before_action :set_genre, only: [:create, :new], if: -> { action_name != 'new' }
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = if params[:q].present?
               Post.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
             elsif params[:tag_id].present?
               Tag.find(params[:tag_id]).posts
             else
               Post.all
             end
  end

  def toggle_publish
    @post = Post.find(params[:id])
    @post.toggle!(:published)
    redirect_to @post, notice: '投稿の公開状態を変更しました。'
  end

  def new
    if user_signed_in?
      @post = Post.new
      @genres = Genre.all
      Rails.logger.debug "Genres in PostsController: #{@genres.inspect}"
    else
      # ゲストユーザーの場合、リダイレクトまたは必要に応じて処理を追加
      redirect_to root_path, alert: 'ゲストユーザーは投稿を作成できません。'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments # コメント一覧を取得
    # 新規コメント投稿用の空のコメントオブジェクトを作成
    @new_comment = Comment.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.find_by(id: params[:post][:genre_id])
    @post = @genre.posts.new(post_params)

    # タグを保存する前に、カンマや改行で分割して配列に変換
    tag_list = params[:post][:tag_list].split(',').map(&:strip)
    @post.tag_list.add(tag_list, parse: true)

    # タグが存在するか確認してから設定
    if tag_list.present?
      @post.tag_list = tag_list

      if @post.save
        redirect_to post_path(@post), notice: '投稿が成功しました。'
      else
        flash.now[:alert] = '投稿に失敗しました。'
        flash.now[:alert_details] = @post.errors.full_messages.join(', ')
        Rails.logger.debug "Post save result: #{@post.errors}"
        render :new
      end
    else
      flash.now[:alert] = 'タグが必要です。'
      render :new
    end
  end


  def search
    @results = Post.where("posted_article LIKE ?", "%#{params[:keyword]}%")
  end

  private

  def set_genre
   @genres = Genre.all
  end

  def post_params
    params.require(:post).permit(:title, :content, :posted_article, :image, :tag_list, :genre_id, :published)
  end
end
