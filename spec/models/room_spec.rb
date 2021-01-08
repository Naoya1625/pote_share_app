require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @user = User.create(
      name:  "User",
      email:      "user@example.com",
      password:   "password",
      password_confirmation:   "password",
    )
    @owner = User.create(
      name:"Owner",
      email: "owner@example.com",
      password: "password",
      password_confirmation: "password"
    )
    @room = @owner.rooms.create(
      room_name: "Room",
      address: "Tokyo",
      price_per_person_per_night: 10000,
      owner_id: @owner.id,
      room_introduction: "Room's introduction!"
    )
    @other_user = User.create(
      name:  "Other User",
      email: "other_user@example.com",
      password: "password",
      password_confirmation: "password",
    )
  end

  # ルーム名、住所、1日あたりの料金、オーナーのid、紹介文があれば有効な状態であること
  it "is valid with a name, email, password and pasword_confirmation" do
    expect(@room).to be_valid
  end

    # 名がなければ無効な状態であること 
      # メールアドレスがなければ無効な状態であること
      # メールアドレスの形式が無効なものなら無効な状態であること


  # ユーザー単位では重複したルーム名を許可しないこと 
  it "does not allow duplicate room names per user" do
    
    @owner.rooms.create(room_name: "Test Room",
                    price_per_person_per_night: 10000,
                    owner_id: @owner.id,
                    room_introduction: "example introduction!",
                    address: "Tokyo",
    )
    new_room = @owner.rooms.build(
      room_name: "Test Room"
    )
    new_room.valid?
    expect(new_room.errors[:room_name]).to include("はすでに存在します")
  end

  # 二人のユーザーが同じルーム名を使うことは許可すること
  it "allows two users to share a project name" do
    @user.rooms.create(
      room_name: "Test Room",
    )
    other_room = @other_user.rooms.build(
      room_name: "Test Room",
    )
    expect(other_room.errors[:room_name]).to_not include("はすでに存在します")
  end



end
