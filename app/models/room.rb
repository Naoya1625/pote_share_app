class Room < ApplicationRecord
  # 外部キーをデフォルトのuser_idをowner_idに変更する
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  before_save   :set_room_introduction
  default_scope -> { order(created_at: :desc) }
  has_one_attached :image

#  mount_uploader :image, ImageUploader
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                      message: "有効な画像形式である必要があります" },
                      size:         { less_than: 5.megabytes,
                      message: "5MB未満である必要があります" }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [600, 600])
  end

  private
    #ルームの紹介文がnilなら空文字列を代入する(before_save)
    def set_room_introduction
      self.room_introduction = "" if ( self.room_introduction == nil )
    end
end
