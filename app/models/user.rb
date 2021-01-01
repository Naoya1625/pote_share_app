class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true

  has_many :rooms, foreign_key: :owner_id, dependent: :destroy
  has_many :reservations, class_name:  "Reservation",
                          foreign_key: "reserving_user_id",
                          dependent:   :destroy
  has_many :reserving_user, through: :relationships, source: :reserved_room


end
