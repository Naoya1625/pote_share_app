class RoomsController < ApplicationController
  #before_action :authenticate_user!

  #new_room GET    /rooms/new
  def new
    @user = current_user
    @room = Room.new
  end

end
