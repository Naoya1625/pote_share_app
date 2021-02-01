require 'rails_helper'

RSpec.describe Room, type: :model do

    let(:room) { FactoryBot.create(:room) }      #owner_id=1 room_name="room-1" address="Tokyo-1"
    let(:user) { FactoryBot.create(:user) }       #id=1 email= "tester1@example.com"
    let(:other_user) { FactoryBot.create(:user) } #id=2 email= "tester2@example.com"


  # ルーム名、住所、1日あたりの料金、オーナーのid、紹介文があれば有効な状態であること
  it "is valid with a name, email, password and pasword_confirmation" do
    expect(room).to be_valid
  end
  
  # ルーム名がなければ無効な状態であること 
  it "is invalid without a room name" do
    room = FactoryBot.build(:room, room_name: nil)
    room.valid?
    expect(room.errors[:room_name]).to include("を入力してください")
  end

  # ユーザー単位では重複したルーム名を許可しないこと 
  it "does not allow duplicate room names per user" do
    room = FactoryBot.create(:room, room_name: "TestRoom", owner: user)
    second_room = FactoryBot.build(:room, room_name: "TestRoom", owner_id: 1)
    second_room.valid?
    expect(second_room.errors[:room_name]).to include("はすでに存在します")
  end

  # 異なるユーザーであれば重複したルーム名を許可すること 
  it "does not allow duplicate room names per user" do
    second_room = FactoryBot.build(:room, room_name: "room-1")
    expect(second_room).to be_valid
  end

  #ルーム紹介文が無ければ無効な状態であること
  it "is invalid without a room introduction" do
    room = FactoryBot.build(:room, room_introduction: nil)
    room.valid?
    expect(room.errors[:room_introduction]).to include("を入力してください")
  end

  #ルームの住所が無ければ無効な状態であること
  it "is invalid without a address" do
    room = FactoryBot.build(:room, address: nil)
    room.valid?
    expect(room.errors[:address]).to include("を入力してください")
  end

  #ルーム紹介文が無ければ無効な状態であること
  it "is invalid without a room introduction" do
    room = FactoryBot.build(:room, room_introduction: nil)
    room.valid?
    expect(room.errors[:room_introduction]).to include("を入力してください")
  end

  #オーナーがいなければ無効な状態であること
  it "is invalid without a room introduction" do
    room = FactoryBot.build(:room, owner_id: nil)
    room.valid?
    expect(room.errors[:owner_id]).to include("を入力してください")
  end



  # 二人のユーザーが同じルーム名を使うことは許可すること
  it "allows two users to share a project name" do
    other_user = FactoryBot.create(:user) #id=2のユーザ
    other_room = FactoryBot.create(:room, room_name: "room-1", owner: other_user)
    expect(other_room).to be_valid
  end








end
