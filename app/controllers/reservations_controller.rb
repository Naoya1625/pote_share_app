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
  end
end
