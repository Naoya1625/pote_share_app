require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user)}

  describe "ユーザ新規登録" do
  let(:user_params) { build(:user) }
    before do 
      visit new_user_registration_path
    end
    scenario 'ユーザ新規登録に成功する' do
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: user_params.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'アカウント登録が完了しました。'
      expect(page).to have_content user_params.name
    end

    scenario '未入力があればユーザ新規登録はできず、エラーメッセージが表示される' do
      fill_in "名前", with: nil
      fill_in "メールアドレス", with: user_params.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content '名前を入力してください'
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: nil
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'Eメールを入力してください'
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: nil
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'Eメールを入力してください'
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: user_params.email
      fill_in 'パスワード', with: nil
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'パスワードを入力してください'
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: user_params.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: nil
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'パスワード（確認用）を入力してください'
    end

    scenario "パスワードと確認用パスワードの入力内容が異なればユーザ新規登録に失敗する" do
      fill_in "名前", with: user_params.name
      fill_in "メールアドレス", with: user_params.email
      fill_in 'パスワード', with: "PASSWORD"
      fill_in 'パスワード確認', with: 'password'
      click_on '新しいアカウントを作成'
      expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    end
  end
  describe "ログイン" do
    scenario 'ログインする' do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン', class: 'original-btn'
      # ログインに成功したことを検証する
      expect(page).to have_content 'ログインしました'
    end

    scenario 'ログアウトする' do
      login user
      visit root_path
      # ログアウトボタンをクリックする
      click_link 'ログアウト', href: destroy_user_session_path
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  describe "ユーザ情報更新" do
    scenario 'パスワードを編集する' do
      login user
      visit edit_user_registration_path
      fill_in "変更後パスワード", with: "changedpassword"
      fill_in "パスワード確認",   with: "changedpassword"
      fill_in "現在のパスワード", with: user.password
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました。'
    end
    scenario 'メールアドレスを編集する' do
      login user
      visit edit_user_registration_path
      fill_in "メールアドレス", with: "changed_#{user.email}"
      fill_in "現在のパスワード", with: user.password
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました。'
      visit users_account_path
      expect(page).to have_content "changed_#{user.email}"
    end

    scenario '現在のパスワードが入力されていなくてもメールアドレス編集は成功する' do
      login user
      visit edit_user_registration_path
      fill_in "メールアドレス", with: "changed_#{user.email}"
      click_on '更新'
      expect(page).not_to have_content '現在のパスワードを入力してください'
      expect(user.email).to eq user.email
    end

    scenario '変更後パスワードとパスワード確認が異なるならパスワードの編集に失敗する' do
      login user
      visit edit_user_registration_path
      fill_in "変更後パスワード", with: "changedpassword"
      fill_in "パスワード確認",   with: "password"
      fill_in "現在のパスワード", with: user.password
      click_on '更新'
      expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      expect(user.password).not_to eq "channgedpassword"
    end

    scenario '現在のパスワードが異なるならパスワードの編集に失敗する' do
      login user
      visit edit_user_registration_path
      fill_in "変更後パスワード", with: "changedpassword"
      fill_in "パスワード確認",   with: "changedpassword"
      fill_in "現在のパスワード", with: "invalid_password"
      click_on '更新'
      expect(page).to have_content '現在のパスワードは不正な値です'
      expect(user.password).not_to eq "channgedpassword"
    end

    scenario 'パスワードの編集には現在のパスワードを必要とする' do
      login user
      visit edit_user_registration_path
      fill_in "変更後パスワード", with: "changedpassword"
      fill_in "パスワード確認",   with: "changedpassword"
      click_on '更新'
      expect(page).to have_content '現在のパスワードを入力してください'
      expect(user.password).not_to eq "channgedpassword"
    end
  end
end
