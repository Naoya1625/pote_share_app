require 'rails_helper'

RSpec.describe "Rooms Api", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room) }

  describe "GET /booking" do
    it "bookingページにアクセスできること" do
      get booking_path(room)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /rooms/new" do
    it "ゲストは新規ルーム登録ページにアクセスできないこと" do
      get new_room_path
      expect(response).to have_http_status(302)
    end

  end
=begin
  describe "POST /rooms" do
    let(:room_params) { FactoryBot.attributes_for(:room) }
    it "ユーザーはルームを登録できること" do
      sign_in user
      
      get new_room_path
      expect {
        post rooms_path, params: room_params
      }.to change(Room, :count).by(1)
    end
  end
=end

  #before_action :authenticate_user!, only: [:posts, :new, :create, :reserve]
  describe "GET /rooms/posts" do
    it "ゲストは登録済みルーム一覧ページにアクセスできないこと" do
      get rooms_posts_path(params: { search: { address: "" } })
      expect(response).to have_http_status(302)
    end
    it "ログイン済みユーザーは登録済みルーム一覧ページにアクセスできること" do
      sign_in user
      get rooms_posts_path(params: { search: { address: "" } })
      expect(response).to have_http_status(200)
    end
  end

  
  describe "GET /rooms/search" do
    it "住所検索によってルーム一覧ページにアクセスできること(住所は入力しない)" do
      get rooms_search_path(params: { search: { address: "" }})
      expect(response).to have_http_status(200)
      expect(Room)
    end
    it "住所検索によって、「入力した住所」が住所に含まれているルームを表示できること" do
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
