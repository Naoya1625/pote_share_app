include ActionDispatch::TestProcess
FactoryBot.define do

  factory :room do
    sequence(:room_name) { |n| "room-#{n}" }
    price_per_person_per_night 10000
    room_introduction "Room's introduction!"
    sequence(:address) { |n| "Tokyo-#{n}" }

    association :owner

    #afterメソッド。Roomインスタンスをbuildした後、画像をつける。
    #after(:build) do |room|
    #  room.image = fixture_file_upload("spec/fixtures/files/test_image.jpeg")
    #end 
    after(:build) do |room|
      room.image = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpeg'), 'image/jpeg')
    end
  end

end
