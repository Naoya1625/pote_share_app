class ReservationsController < ApplicationController
  #予約済みルーム一覧
  #reservations GET    /reservation
  def index
    @reservations = current_user.reservations
  end

  #new_reservation GET    /reservations/new
  def new

  end

  #reservations  POST   /reservations
  def create
    #room = Room.find_by(id: params[:id])
    @reserving_user_id = params[:reserving_user_id]
    @reserved_room_id = params[:reserved_room_id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @number_of_people = params[:number_of_people]
    @id = params[:id]

    @reservation = Reservation.new(reservation_params)
    #この中で合計金額を計算

    @reservation.calculate_amount

    if @reservation.save

      flash[:success] = "予約を確定しました。."
      redirect_to rooms_url
    else
      render 'rooms/booking'
    end
  end

  private
  def reservation_params
    params.permit(:start_date, :end_date,
                                 :number_of_people, :reserving_user_id, :reserved_room_id )
  end
#.merge(reserving_user_id: current_user.id, reserved_room_id: params[:id])
end
