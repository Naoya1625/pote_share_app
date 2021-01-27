require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { FactoryBot.create(:user)}
  scenario 'ログインする' do
    # トップページを開く
    visit root_path
    # ログインページに行く
    visit new_user_session_path

    # ログインフォームにEmailとパスワードを入力する
    fill_in "メールアドレス", with: user.email
    fill_in 'パスワード', with: 'password'
    # ログインボタンをクリックする
    click_on 'ログイン', class: 'original-btn'
    # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました'
  end

  scenario 'ログアウトする' do
    visit new_user_session_path

    # ログインフォームにEmailとパスワードを入力する
    fill_in "メールアドレス", with: user.email
    fill_in 'パスワード', with: 'password'
    # ログインボタンをクリックする
    click_on 'ログイン', class: 'original-btn'

    visit root_path
    # ログアウトボタンをクリックする
    click_link 'ログアウト', href: destroy_user_session_path
    save_and_open_page
    expect(page).to have_content 'ログアウトしました。'
  end
=begin
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
   
    visit new_user_registration_path
    click_link "登録"
    fill_in "名前", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード確認", with: user.password
    click_button "新しいアカウントを作成"
    
    visit new_room_path
    expect{
     fill_in "room_name", with: "Room"
     fill_in "ルーム紹介", with: "RoomInt"
     fill_in "料金", with: 1000
     fill_in "住所" , with: "Tokyo"
     fill_in "ルーム画像", with: "pote_share_ptpn.png"
     click_button "登録"
     
     expect(page).to have_content "Room was successfully created."}.to change(user.rooms, :count).by(1)

 end
=end


end
