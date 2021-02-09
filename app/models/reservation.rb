class Reservation < ApplicationRecord
  belongs_to :reserving_user, class_name: "User"
  belongs_to :reserved_room, class_name: "Room"
  validates :reserving_user_id, presence: true
  validates :reserved_room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_people, presence: true
  validates :amount, presence: true
  validates :reserving_user_id, uniqueness: { scope: :reserved_room_id } #一人のユーザは1つの部屋の重複予約はできない。

  #予約の日数、人数から合計金額を計算し、結果を返す(そしてコントローラで変数に格納) そして、終了日より開始日が後になっていたらfalseを返す。
  def calculate_amount
    days = self.calculate_number_of_date
    #合計金額=1日あたりの金額*人数*日数
    return false if ( days == false )
    amount = Room.find(self.reserved_room_id).price_per_person_per_night * number_of_people * days 
    return amount 
  end

  #予約日数を返す
  def calculate_number_of_date
    return false unless self.start_date || self.end_date
    start_date = self.start_date 
    end_date = self.end_date
    start_day = start_date.day                #開始日
    end_day = end_date.day                    #終了日
    start_month = start_date.month            #開始月
    end_month = end_date.month                #終了月
    start_year = start_date.year              #開始年
    end_year = end_date.year                  #終了年
    number_of_people = self.number_of_people  #人数
    last_day = Date.new( start_year, start_month, -1).day  #開始日の末日(28日or29日or30日or31日)を取得.(計算用)

    return false if date_is_invalid?(start_day, end_day)  #入力した日付が前後していればエラーメッセージを追加し、falseを返す
    
    if ( start_month == end_month )                # if 開始日と終了日が同じ月であるなら。
      days = end_day - start_day                   #日数を計算
    elsif ( start_month != end_month )             # eslif 開始日と終了日が異なる月であるなら。
      days = ( last_day - start_day) + end_day     #日数を計算
    end
    days
  end

  #入力した日付が前後していればエラーメッセージを追加し、falseを返すメソッド
  def date_is_invalid?(start_date, end_date)
    if self.start_date.past?
      errors.add(:start_date, "開始日には今日以降の日付を選択してください")
    elsif start_date == end_date
      errors.add(:start_date, "開始日と終了日に同じ日付を選択しています")
    elsif start_date > end_date
      errors.add(:start_date, "開始日が終了日より後の日付になっています")
    end
  end

end
