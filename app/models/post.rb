class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :field, presence: true
  validate  :picture_size

  private

  # アップデートされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB未満にしてください")
    end
  end
end
