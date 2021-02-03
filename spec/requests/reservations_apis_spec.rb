require 'rails_helper'
require 'support/reservations_spec_helper'
RSpec.describe "ReservationsApis", type: :request do
  include ReservationsSpecHelper
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room) }
  describe "GET /reservations" do
    it "ログイン済みユーザーは予約済みルーム一覧画面にアクセスできること" do
      sign_in user
      get reservations_path
      expect(response).to have_http_status(200)
    end
    it "ゲストは予約済みルーム一覧画面にアクセスできないこと" do
      get reservations_path
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /reservations/index" do
    it "ログイン済みユーザーは登録済みルーム一覧画面にアクセスできること" do
      sign_in user
      get reservations_path
      expect(response).to have_http_status(200)
    end
    it "ゲストは登録済みルーム一覧画面にアクセスできないこと" do
      get reservations_path
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /reservations" do
    it "ログイン済みユーザーは予約済みルーム一覧画面にアクセスできること" do
      sign_in user
      get reservations_path
      expect(response).to have_http_status(200)
    end
    it "ゲストは予約済みルーム一覧画面にアクセスできないこと" do
      get reservations_path
      expect(response).to have_http_status(302)
    end
  end


  # :show
  describe "GET /reservations/:id" do

    let(:reservation_attrs) do {
        reserving_user_id: user.id,
        reserved_room_id: room.id,
        start_date: Date.tomorrow,
        end_date: Date.tomorrow.tomorrow,
        number_of_people: 2,
        amount: 10000
      } 
    end
    let(:reservation) { FactoryBot.create(:reservation, reservation_attrs) }
    let(:req_params) { { reservation: reservation_req_params(reservation) } }
    it "ログイン済みユーザーは予約済みルーム一覧画面にアクセスできること" do
      sign_in user
      get reservation_path(reservation.id)
      expect(response).to have_http_status(200)
    end
    it "ゲストは予約済みルーム一覧画面にアクセスできないこと" do
      get reservations_path
      expect(response).to have_http_status(302)
    end
  end


    # :confirm
    describe "POST /reservation/confirm" do

      let(:reservation_confirm_params) do {
          reserving_user_id: user.id,
          reserved_room_id: room.id,
          start_date: Date.tomorrow,
          end_date: Date.tomorrow.tomorrow,
          number_of_people: 2
        } 
      end
      it "ログイン済みユーザーは予約を作成できること(まだ予約は確定されない)" do
        sign_in user
        post confirm_path, params: reservation_confirm_params
        expect(response.body).to include("予約内容確認")
      end
      it "ゲストはルームを予約できないこと" do
        post confirm_path, params: reservation_confirm_params
        expect(response.body).not_to include("予約内容確認")
      end
    end


    # :create
    describe "POST /reserve" do
      let(:reservation_attrs) do {
          reserving_user_id: user.id,
          reserved_room_id: room.id,
          start_date: Date.tomorrow,
          end_date: Date.tomorrow.tomorrow,
          number_of_people: 2,
          amount: 1000
        } 
      end
      let(:reservation) { FactoryBot.build(:reservation, reservation_attrs) }
      let(:req_params) { { reservation: reservation_req_params(reservation) } }
      it "ログイン済みユーザーは予約を確定できること" do
        sign_in user
        expect{ post reserve_path, params: req_params }.to change{ Reservation.count }.by(+1)
        expect(response).to redirect_to reservation_path(1)
      end
      it "ゲストはルームを予約できないこと" do
        expect{ post reserve_path, params: req_params }.to change{ Reservation.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
end
