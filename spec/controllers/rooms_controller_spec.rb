require 'rails_helper'

#ルームの登録を行うコントローラ
RSpec.describe RoomsController, type: :controller do
  describe "#my_room" do
    # 認証済みのユーザーとして
    context "as a authenticated_user" do
      before do
        @user = FactoryBot.create(:user)
      end
      # 正常にレスポンスを返すこと 
      it "responds successfully" do
        sign_in @user
        get :posts
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @user
        get :posts
        expect(response).to have_http_status "200"
      end
    end

    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        get :posts
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること 
      it "redirects to the sign-in page" do
        get :posts
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      # ルームを登録できること 
      it "adds a room" do
        room_params = FactoryBot.attributes_for(:room)
        sign_in @user
        expect {
          post :create, params: { room: room_params }
        }.to change(@user.rooms, :count).by(1)
      end
    end

    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        room_params = FactoryBot.attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること 
      it "redirects to the sign-in page" do
        room_params = FactoryBot.attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to redirect_to "/users/sign_in"
      end 
    end
  end
end