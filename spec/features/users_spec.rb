require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { FactoryBot.create(:user)}

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
  scenario '現在のパスワードが入力されていなければメールアドレス編集は失敗する' do
    login user
    visit edit_user_registration_path
    fill_in "メールアドレス", with: "changed_#{user.email}"
    click_on '更新'
    expect(page).to have_content '現在のパスワードを入力してください'
    expect(user.email).not_to eq "changed_#{user.email}"
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
end
