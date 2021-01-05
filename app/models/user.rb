class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save   :set_introduction
  before_save   :downcase_email
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true


  has_many :rooms, foreign_key: :owner_id, dependent: :destroy

  has_many :reservations, class_name:  "Reservation",
                          foreign_key: "reserving_user_id",
                          dependent:   :destroy
  has_many :reserving_user, through: :reservations, source: :reserved_room

    # ルームの予約をする
    def reserve(room)
      self.reservations << room
    end
  
    # 現在のユーザーが予約してたらtrueを返す
    def reserving?(room)
      self.reservations.include?(room)
    end
  private
    #ユーザの紹介文がnilなら空文字列を代入する(before_save)
    def set_introduction
      self.introduction = "" if ( self.introduction == nil )
    end

    # メールアドレスをすべて小文字にする(before_save)
    def downcase_email
      self.email = email.downcase
    end

end
