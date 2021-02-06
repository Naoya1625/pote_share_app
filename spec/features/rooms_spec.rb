require 'rails_helper'

RSpec.feature "Rooms", type: :feature do
  let(:user) { create(:user) }
  let(:room) { create(:room) }

  describe "ルーム新規登録" do
    let(:room_params) { build(:room) }
    before do
      login user
      
    end
    scenario "ルーム登録に成功すること" do
      visit new_room_path
      fill_in "ルーム名", with: room_params.room_name
      fill_in "ルーム紹介", with: room_params.room_introduction
      fill_in "料金", with: room_params.price_per_person_per_night
      fill_in "住所", with: room_params.address
      click_on "登録"
      expect(page).to have_content "住所を入力してください"
    end

  end
end
