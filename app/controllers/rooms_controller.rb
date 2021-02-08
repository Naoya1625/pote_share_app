class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:posts, :new, :create, :reserve]

  #rooms  GET    /rooms
  def posts
    @rooms = current_user.rooms
  end

  #new_room GET    /rooms/new ルーム登録画面
  def new
    @user = current_user
    @room = Room.new
  end

  #rooms  POST   /rooms
  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = t('.room_was_successfully_created')
      redirect_to booking_url(@room)
    else
      flash[:danger] = t('.room_save_failed')
      render :new
    end
  end

  #room  GET    /rooms/:id
  def booking
    @room = Room.find(params[:id])
    @user = User.find(@room.owner_id)
  end

  #rooms_search GET /rooms/search
  def search
    if params[:search][:address].present?
      @rooms = Room.search_area(params[:search][:address])
      @searching_address = params[:search][:address]
    else
      @rooms = Room.search_keyword(params[:search][:keyword])
      @searching_keywords = params[:search][:keyword]
    end
  end


  private
    def room_params
      params.require(:room).permit(:room_name, :price_per_person_per_night,
                                  :owner_id, :address, :image,
                                  :room_introduction)
    end


    def room_search_params
      params.fetch(:search, {}).permit(:room_name, :address)
    end
end
