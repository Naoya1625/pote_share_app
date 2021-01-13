class ReservationsController < ApplicationController
  #予約済みルーム一覧
  #reservations GET    /reservation      #reservations GET    /reservations(.:format)   reservations#index
  def index

    @reservations = Reservation.all.order(created_at: :asc)

    @rooms = Room.all
    @users = User.all


  end

  #new_reservation GET    /reservations/new
  def new

  end

  #reservations  POST   /reservations
  def create

    @reservation = Reservation.new(reservation_params)
    
    @reservation.calculate_amount #合計金額を計算しamount属性をセット
    if @reservation.save
      flash[:success] = "予約を確定しました"
      redirect_to reservations_url
    else
      render 'rooms/booking'
    end
  end

  private
  def reservation_params
    params.permit(:start_date, :end_date,
                  :number_of_people, :reserving_user_id,
                  :reserved_room_id )
  end

end
