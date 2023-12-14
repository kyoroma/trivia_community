class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  ## 名前を保存するためのカラムを追加
  validates :name, presence: true

  attribute :is_active, :boolean, default: true

  def guest?
    email == 'guest@example.com'
  end

  # ゲストユーザーを作成するメソッド
  def self.create_guest
    # 既に同じメールアドレスのユーザーが存在するか確認
    guest_user = find_or_initialize_by(email: 'guest@example.com') do |user|
      user.name = 'Guest User'
      user.password = Devise.friendly_token[0, 20]
      user.guest = true
    end

    if guest_user.save
      guest_user
    else
      # ゲストユーザーの作成に失敗した場合の処理を追加
      # 例えばエラーログを記録したり、特定の処理を行ったりします
      Rails.logger.error("Failed to create guest user: #{guest_user.errors.full_messages}")
      nil
    end
  end

  def active_for_authentication?
    super && is_active?
  end
end
