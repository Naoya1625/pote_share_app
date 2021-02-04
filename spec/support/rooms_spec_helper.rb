module RoomsSpecHelper

  # ルーム登録のリクエストに与えるパラメータを生成
  def room_req_params(room)
    room.serializable_hash(only: [
      :owner_id,
      :room_name,
      :price_per_person_per_night,
      :room_introduction,
      :address,
      :image
    ])
  end

end