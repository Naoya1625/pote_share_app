class ReservationsController < ApplicationController
  #予約済みルーム一覧
  #reservations GET    /reservation      #reservations GET    /reservations(.:format)   reservations#index
  def index
    @reservations = Reservation.all.page(params[:page]).per(10).order(created_at: :asc)
    @rooms = Room.all
    @users = User.all
  end



  #confirm   POST   "/reservations/confirm"
  def confirm
    @reservation = Reservation.new(reservation_confirm_params)
    @room = Room.find(@reservation.reserved_room_id)
    @reservation.calculate_amount
    binding.pry
    render "rooms/booking" if @reservation.invalid?
  end
  #confirmation get "/reservations/confirmation"
  #def confirmation
    #@user = current_user
    #@reservation = Reservation.new(reservation_confirm_params) renderしてるからいらないのか。。？
    #@room = Room.find(@reservation.reserved_room_id)

  #end


  #reserve POST   /reserve
  def create
    @reservation = Reservation.new(reservation_params)
    if params[:back]
      render "rooms/booking"
    elsif @reservation.save
      flash[:notice] = t('.reservation_was_successfully_created.')
      redirect_to reservations_url
    else
      render "rooms/booking"
    end
  end
=begin
  #reservations  POST   /reservations
  def create

    @reservation = Reservation.new(reservation_params)
    
    @reservation.calculate_amount #合計金額を計算しamount属性をセット

    if @reservation.save
      flash[:success] = t('.confirmed_reservation')
      redirect_to reservations_url
    else
      render 'rooms/booking'
    end
  end
=end
  private

  def reservation_confirm_params
    params.permit(:start_date, :end_date,
                  :number_of_people, :reserving_user_id,
                  :reserved_room_id )
  end
  def reservation_params
    params.permit(:start_date, :end_date,
                  :number_of_people, :reserving_user_id,
                  :reserved_room_id, :amount)
  end

end
