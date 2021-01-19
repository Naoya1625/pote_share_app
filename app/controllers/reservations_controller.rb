class ReservationsController < ApplicationController

  #予約済みルーム一覧
  #reservations GET    /reservation      #reservations GET    /reservations(.:format)   reservations#index
  def index
    @reservations = Reservation.order(created_at: :asc)
    @rooms = Room.all
    @users = User.all
  end


  #confirm   POST   "/reservations/confirm"
  def confirm

    @reservation = Reservation.new(reservation_confirm_params)
    @user = current_user
    @room = Room.find(@reservation.reserved_room_id)
    if @reservation && @amount = @reservation.calculate_amount
      #@amountに合計金額をいれた結果、値が入っているなら。
      return
    else
      #合計金額がfalseなら
      flash[:danger] = t('.the_reservation_was_not_created_successfully')
      redirect_to booking_url(@room)
    end
  end

  #reserve POST   /reserve
  def create
    @reservation = Reservation.create(reservation_params)
    @room = Room.find(@reservation.reserved_room_id)
    if params[:back]
      render "rooms/booking"
    elsif @reservation.valid?
      flash[:notice] = t('.reservation_was_successfully_created')
      redirect_to reservation_url(@reservation)
    else
      render "rooms/booking"
    end
  end

  #reservation   get   /reservation/:id
  def show

  end

  private

  def reservation_confirm_params
    params.permit(:start_date, :end_date,
                  :number_of_people, :reserving_user_id,
                  :reserved_room_id)
  end
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date,
                  :number_of_people, :reserving_user_id,
                  :reserved_room_id, :amount)
  end


end
