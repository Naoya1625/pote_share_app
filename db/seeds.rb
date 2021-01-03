#サンプルユーザー
20.times do |n|
  name  = "aaa#{n+1}"
  email = "aaa#{n+1}@aaa.com"
  password = "aaaaaa"
  image = "pote_share_logo.png"
  introduction = "サンプル自己紹介文です"
  User.create!(name:  name,
        email: email,
        password:              password,
        password_confirmation: password,
        image: image,
        introduction: introduction)
end

=begin

#サンプルルーム
20.times do |n|
  room_name  = "room#{n+1}"
  cost = 1000 * (n+1)
  owner_id = ( n + 1 )
  image = "pote_share_logo.png"
Room.create!(room_name:  room_name,
              price_per_person_per_night: cost,
              owner_id: owner_id,
              image: image)
end

=end

