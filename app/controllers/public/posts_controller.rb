class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :set_genre, only: [:create, :new], if: -> { action_name != 'new' }

  def index
    @q = params[:q]
    @tag_id = params[:tag_id]
    @tags = find_or_create_tags_from_params(params)

    if @q.present? || @tags.present?
      @posts = if @q.present?
        Post.search(params)
      elsif @tag_id.present?
        Post.joins(:post_tags).where(post_tags: { tag_id: @tag_id })
      elsif @tags.present?
        Post.joins(:post_tags).where(post_tags: { tag_id: @tags.map(&:id) })
      else
        Post.all
      end

      @posts = @posts.page(params[:page]).per(10)
    else
      @posts = Post.none  # 検索条件がない場合、結果なし
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

    # タグが存在するか確認してから設定
    if @post.tags.present?

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
    if params[:tag_list].present?
      @results = Post.tagged_with(params[:tag_list])
    else
      @results = Post.where("posted_article LIKE ?", "%#{params[:keyword]}%")
    end
  end

  private

  def set_genre
   @genres = Genre.all
  end

  def post_params
    p=params.require(:post).permit(:title, :content, :posted_article, :image, :tags, :genre_id, :published, :tag_id)
    tags=find_or_create_tags_from_params(p)
    p.merge(tags: tags)
  end

  def find_or_create_tags_from_params(p)
    tag_names = p[:tags]&.split(',')&.map(&:strip) || []
    tag_names.map{|tag_name|Tag.find_or_create_by(name: tag_name)}
  end
end
