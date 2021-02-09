require 'rails_helper'

RSpec.describe "DeviseUsersApi", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'ユーザ登録が成功すること' do
        expect {
          post user_registration_path, params: { user: user_params }
        }.to change(User, :count).by 1
      end
      it '登録後、ルートへリダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end
      it 'createが失敗すること' do
        expect {
          post user_registration_path, params: { user: invalid_user_params }
        }.to_not change(User, :count)
      end
      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end

  describe 'GET /users/account' do
    subject { get users_account_path }
    context 'ログインしている場合' do
      before do
        sign_in user
        subject
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
      it 'ユーザ名が表示されていること' do
        expect(response.body).to include user.email
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/profile' do
    subject { get users_profile_path }
    context 'ログインしている場合' do
      before do
        sign_in user
        subject
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/profile' do
    subject { get users_profile_path }
    context 'ログインしている場合' do
      before do
        sign_in user
        subject
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/edit' do
    subject { get edit_user_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in user
        subject
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

#パスワード編集(users/edit)はfeature specにて作成！
end
