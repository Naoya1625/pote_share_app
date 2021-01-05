class RoomsController < ApplicationController
  #before_action :authenticate_user!

  #登録済みルーム一覧(未)
  #rooms  GET    /rooms
  def index
    @rooms = current_user.rooms
  end

  #new_room GET    /rooms/new
  def new
    @user = current_user
    @room = Room.new
  end

  #rooms  POST   /rooms
  def create
    @room = current_user.rooms.build(room_params)
    @room.image.attach(params[:room][:image])
    if @room.save
      #flash-message多言語化すること
      flash[:success] = "Room was successfully created."
      #とりあえずroot
      redirect_to booking_url(@room)
    else
      render 'homes/index'
    end
  end

  #room  GET    /rooms/:id
  def booking
    @room = Room.find(params[:id])
    @user = User.find(@room.owner_id)
  end


  # get "rooms/newなんちゃら" ここの確定を押すと正式に予約が作られる。
   #予約確認画面
  #def new
  #  @reservation = Reservation
  #end

  #reserve POST   /reserve
  def reserve
    @room = Reservation.new(reservation_params)
    if room.save
      flash[:success] = "せいこうううう"
      redirect_to root_url
    end
  end


  private
  def room_params
    params.require(:room).permit(:room_name, :price_per_person_per_night,
                                 :owner_id, :address, :image,
                                 :room_introduction)
  end
  def reservation_params
    params.require(:reservation).permit(:reserving_user_id, :reserved_room_id)
  end
end
