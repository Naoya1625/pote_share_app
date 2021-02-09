require 'rails_helper'

#ユーザ登録、編集、削除、更新を行うコントローラ
RSpec.describe Users::RegistrationsController, type: :controller do
=begin  
  describe "new" do
    #ユーザ登録画面
    context "a logged in user" do  #ログイン中のユーザがアクセス
      before do
        @user = FactoryBot.create(:user)
      end
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      # rootに画面にリダイレクトすること 
      it "redirects to the sign-in page" do
        sign_in @user
        get :new
        expect(response).to redirect_to root_url
      end
    end

    context "as a not logged in user" do  #ログインしていないユーザがアクセス
      # 正常にレスポンスを返すこと 
      it "responds successfully" do
        get :new
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        get :new
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "create" do
    #new画面からのpost
  end

  describe "edit" do
    #get ユーザ編集画面(accountページのリンク先)
    
  end

  describe "update" do
    #editページからのpatchリクエスト
  end

  describe "destroy" do
    #editページからユーザ削除リンクを押した時
  end

=end

end
