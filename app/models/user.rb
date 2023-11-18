class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## 名前を保存するためのカラムを追加
  validates :name, presence: true

  # ゲストユーザーを作成するメソッド
  def self.create_guest
    create!(
      name: "ゲストユーザー",
      email: "guest@example.com",
      password: SecureRandom.hex(10)
    )
  end
end
