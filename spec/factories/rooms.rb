include ActionDispatch::TestProcess

FactoryBot.define do
 
  #normal
  factory :room do
    sequence(:room_name) { |n| "room-#{n}" }
    price_per_person_per_night 10000
    room_introduction "Room's introduction!"
    sequence(:address) { |n| "Tokyo-#{n}" }
    association :owner

    #afterメソッド。Roomインスタンスをbuildした後、画像をつける。
    after(:build) do |room|
      room.image = fixture_file_upload("spec/fixtures/files/test_image.jpeg")
    end    
    
    
    #こちらの記述でも同様にテストが失敗する。
    #after(:build) do |room|
    #  room.image = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpeg'), 'image/jpeg')
    #end
  end

end

  #ファクトリを複数定義する場合に使う
=begin
  factory :room_owner_id_1, class: Room  do
    sequence(:room_name) { |n| "room-1" }
    price_per_person_per_night 10000
    room_introduction "Room's introduction!"
    address "Tokyo"
    association :owner
  end
=end

