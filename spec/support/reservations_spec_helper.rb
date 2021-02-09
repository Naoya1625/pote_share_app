module ReservationsSpecHelper

  # 予約のリクエストに与えるパラメータを生成
  def reservation_req_params(reservation)
    reservation.serializable_hash(only: [
      :start_date,
      :end_date,
      :number_of_people, 
      :reserving_user_id,
      :reserved_room_id,
      :amount
    ])
  end
  
end