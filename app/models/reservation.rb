class Reservation < ApplicationRecord
  belongs_to :reserving_user, class_name: "User"
  belongs_to :reserved_room, class_name: "Room"
  validates :reserving_user_id, presence: true
  validates :reserved_room_id, presence: true
end
