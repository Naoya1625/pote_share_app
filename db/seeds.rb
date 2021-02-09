#サンプルユーザー
20.times do |n|
  name  = "aaa#{n+1}"
  email = "aaa#{n+1}@aaa.com"
  password = "aaaaaa"
  image = "pote_share_logo.png"
  introduction = "サンプル自己紹介文です"

  user = User.new(name:  name,
        email: email,
        password: password,
        password_confirmation: password,
        introduction: introduction)
        image_path = Rails.root.join("app/assets/images/images.jpeg").to_s
        user.image.attach(io: File.open(image_path), filename: "images.jpeg")
        user.save!
end

#サンプルルーム
20.times do |n|
  room_name  = "サンプル-room#{n+1}"
  cost = 1000 * ( n + 1)
  owner_id = ( n + 1 )

  
  address = "サンプル住所#{n+1}番地"
  room_introduction = "ルーム#{n+1}の紹介文です。"
  room = User.find(owner_id).rooms.new(room_name:  room_name,
                              price_per_person_per_night: cost,
                              owner_id: owner_id,
                              address: address,
                              room_introduction: room_introduction
                            )
  image_path = Rails.root.join("app/assets/images/images.jpeg").to_s
  room.image.attach(io: File.open(image_path), filename: "images.jpeg")
  room.save!
end

#予約
users = User.all
rooms = Room.all
number_of_people = 3
today = Date.today
20.times do |n|
  room = Room.find(n+1) 
  start_date = today + (n+2)
  end_date = today + (n+4)
  reserving_user_id = User.find(n+1).id
  reserved_room_id = room.id
  created_at = today + (n+1)
  amount = ( end_date - start_date ) * number_of_people * room.price_per_person_per_night
  reservation = Reservation.new(start_date: start_date,
                     end_date: end_date,
                     number_of_people: number_of_people,
                     reserving_user_id: reserving_user_id,
                     reserved_room_id: reserved_room_id,
                     amount: amount
                    )
  reservation.update_attribute(:created_at, created_at)
  
end