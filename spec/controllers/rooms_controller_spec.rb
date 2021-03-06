require 'rails_helper'

#ルームの登録を行うコントローラ
RSpec.describe RoomsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }



  describe "#booking" do
    let(:room) { FactoryBot.create(:room) }

    # 認証済みのユーザーとして
    context "as a authenticated_user" do

      # 正常にレスポンスを返すこと 
      it "responds successfully" do
        #sign_in user
        get :booking, params: {id: room.id}
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in user
        get :booking, params: {id: room.id}
        expect(response).to have_http_status "200"
      end
    end

    # ゲストとして
    context "as a guest" do
      # 正常にレスポンスを返すこと 
      it "responds successfully" do
        get :booking, params: {id: room.id}
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        get :booking, params: {id: room.id}
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#posts" do

    # 認証済みのユーザーとして
    context "as a authenticated_user" do
      # 正常にレスポンスを返すこと 
      it "responds successfully" do
        sign_in user
        get :posts
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in user
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
  
end