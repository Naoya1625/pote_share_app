require 'rails_helper'
require 'support/rooms_spec_helper'

RSpec.describe "Rooms Api", type: :request do
  include RoomsSpecHelper

  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room) }

  # :booking
  describe "GET /booking" do
    it "bookingページにアクセスできること" do
      get booking_path(room)
      expect(response).to have_http_status(200)
    end
  end

  # :new
  describe "GET /rooms/new" do
    it "ログイン済みはユーザーはルーム登録ページにアクセスできること" do
      sign_in user
      get new_room_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("ルーム情報登録")
    end
    
    it "ゲストは新規ルーム登録ページにアクセスできないこと" do
      get new_room_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

=begin  このテストはモデルスペックにて代用する！
  describe "POST /rooms" do
    let(:room_attrs) do { 
      room_name: "test_room_name",
      price_per_person_per_night: 10000,
      owner_id: user.id,
      room_introduction: "test_room_introduction",
      address: "test_address"
    }
  end
  let(:room) { FactoryBot.build(:room, room_attrs) }
  let(:room_params) { { room: room_req_params(room) } }
    it "ユーザーはルームを登録できること" do
      sign_in user
      binding.pry
      get new_room_path
      expect {
        post rooms_path, params: room_params
      }.to change(Room, :count).by(1)
    end
  end
=end
  # :create
  describe "POST /rooms" do
    let(:room_attrs) do { 
      room_name: "test_room_name",
      price_per_person_per_night: 10000,
      owner_id: user.id,
      room_introduction: "test_room_introduction",
      address: "test_address"
    }
    end
    let(:room) { FactoryBot.build(:room, room_attrs) }
    let(:room_params) { { room: room_req_params(room) } }
    it "ゲストはルーム登録しようとすると、ログイン画面にリダイレクトされること" do
      get new_room_path
      post rooms_path, params: room_params
      expect(response).to redirect_to new_user_session_path
    end
  end


  # :posts
  describe "GET /rooms/posts" do
    it "ログイン済みユーザーは登録済みルーム一覧ページにアクセスできること" do
      sign_in user
      get rooms_posts_path(params: { search: { address: "" } })
      expect(response).to have_http_status(200)
    end
    it "ゲストは登録済みルーム一覧ページにアクセスできないこと" do
      get rooms_posts_path(params: { search: { address: "" } })
      expect(response).to have_http_status(302)
    end
  end

  # :search
  describe "GET /rooms/search" do
    it "住所検索によってルーム一覧ページにアクセスできること(住所は入力しない)" do
      get rooms_search_path(params: { search: { address: "" }})
      expect(response).to have_http_status(200)
      expect(Room)
    end
    it "住所検索によって、入力した住所が住所に含まれているルームを表示できること" do
      get rooms_search_path(params: { search: { address: room.address }})
      expect(response.body).to include(room.address)
    end
    it "キーワード検索によって、入力したキーワードがルーム名に含まれているルームを表示できること" do
      get rooms_search_path(params: { search: { keyword: room.room_name }})
      expect(response.body).to include(room.room_name)
    end
    it "キーワード検索によって、入力したキーワードがルーム紹介に含まれているルームを表示できること" do
      get rooms_search_path(params: { search: { keyword: room.room_introduction }})
      expect(response.body).to include(room.room_name)
    end
    it "住所検索によって、入力した住所が住所に含まれていないルームは表示しないこと" do
      get rooms_search_path(params: { search: { address: "存在しない住所" }})
      expect(response.body).not_to include(room.address)
      expect(response.body).to include("検索結果 : 0件")
    end
    it "キーワード検索によって、入力したキーワードがルーム名またはルーム紹介に含まれていないルームは表示しないこと" do
      get rooms_search_path(params: { search: { keyword: "存在しない住所" }})
      expect(response.body).not_to include(room.room_name)
      expect(response.body).to include("検索結果 : 0件")
    end
  end

end
