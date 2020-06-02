class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :employee_number, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :post
  has_many :comments, dependent: :destroy

  # 登録時にメールアドレス不要にする
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # パスワードなしで更新する
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def feed
    Post.all
  end

  # いいね
  def like(post)
    likes << post
  end

  # いいね解除
  def unlike(post)
    favorites.find_by(post_id: post.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrue
  def likes?(post)
    likes.include?(post)
  end
end
