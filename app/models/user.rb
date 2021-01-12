class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #before_save :set_user_image
  before_save :set_introduction
  before_save :downcase_email

  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }



  has_many :rooms, foreign_key: :owner_id, dependent: :destroy

  has_many :reservations, class_name:  "Reservation",
                          foreign_key: "reserving_user_id",
                          dependent:   :destroy
  has_many :reserving_user, through: :reservations, source: :reserved_room

  #ActiveAtorage
  has_one_attached :image

  # ルームの予約をする
  def reserve(room)
    self.reservations << room
  end

  # 表示用のリサイズ済み画像を返す
  def display_image(width, height)
    image.variant(resize_to_limit: [width, height])
  end

  # 現在のユーザーが予約してたらtrueを返す
  def reserving?(room)
    self.reservations.include?(room)
  end

  # ユーザ情報更新にはパスワードを必要としない
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

  private

    #ユーザの紹介文がnilなら空文字列を代入する(before_save)
    def set_introduction
      self.introduction = "" if ( self.introduction == nil )
    end

    #ユーザ画像がnilならデフォルト画像を代入する(before_save)
    def set_user_image
      self.image = "default_icon-9263fc59c414b7228d256fc178dcb22183561357950a68f5ad086ba7ee054974.jpg" if ( self.image == nil )
    end

    # メールアドレスをすべて小文字にする(before_save)
    def downcase_email
      self.email = email.downcase
    end

end
