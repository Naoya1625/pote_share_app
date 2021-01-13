class Reservation < ApplicationRecord
  belongs_to :reserving_user, class_name: "User"
  belongs_to :reserved_room, class_name: "Room"
  validates :reserving_user_id, presence: true
  validates :reserved_room_id, presence: true

  attr_accessor :amount

  #予約の日数、人数から合計金額を計算し、DBに記憶する. そして、終了日より開始日が後になっていたらfalseを返す。
  def calculate_amount
    start_date = self.start_date
    end_date = self.end_date
    number_of_people = self.number_of_people
    if ( start_date.month == end_date.month )                     #開始日と終了日が同じ月であるなら。
      days = end_date.day - start_date.day                        #日数を計算
    elsif ( start_date.month != end_date.month )                  #開始日と終了日が異なる月であるなら。
      last_day = Date.new(start_date.year,start_date.month, -1)  #last_dayに開始日の末日(28日or29日or30日or31日)を取得.
      days = ( last_day.day - start_date.day) + end_date.day     #日数を計算
    end
    
    return false if ( days <= 0 )    #終了日より開始日が後になっていたらfalseを返す

    #合計金額=1日あたりの金額*人数*日数
    amount = Room.find(self.reserved_room_id).price_per_person_per_night * number_of_people * days 
    self.amount=(amount)
  end


end
