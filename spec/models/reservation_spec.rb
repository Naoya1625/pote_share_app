require 'rails_helper'

RSpec.describe Reservation, type: :model do

  before do
    @user = User.create(
      name:  "Naoya",
      email:      "example@example.com",
      password:   "password",
      password_confirmation:   "password",
    )
    @owner = User.create(name:"Taro",
      email: "taro@taro.com",
      password: "password",
      password_confirmation: "password")
    @room = Room.create(
      room_name: "Room",
      address: "Tokyo",
      price_per_person_per_night: 20000,
      owner_id: @owner.id,
      room_introduction: "Room's introduction!"
    )
    @reservation = Reservation.new(
      reserving_user_id: @user.id,
      reserved_room_id: @room.id,
      start_date: Date.today,
      end_date: Date.tomorrow.tomorrow,
      number_of_people: 2
    )
  end

  # 予約者が存在しなければ、予約は、無効である。
  it "is invalid without a reserving user's id" do
    reservation = Reservation.new(
      reserving_user_id: nil
    )
    reservation.valid?
    expect(reservation.errors[:reserving_user_id]).to include("を入力してください")
  end

  # ルームが存在しなければ、予約は、無効である。
  it "is invalid without a reserving user's id" do
    reservation = Reservation.new(
      reserved_room_id: nil
    )
    reservation.valid?
    expect(reservation.errors[:reserved_room_id]).to include("を入力してください")
  end

end
