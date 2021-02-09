module ApplicationHelper

  def simple_time(time)
    time.strftime("%Y-%m-%d %H:%M ")
  end 

  #予約済みルーム一覧画面にて背景色をセットする
  def set_css
    if @flag == "1"
      @flag = "0"
      return "background-lightgray"
    elsif @flag == "0"
      @flag = "1"
      return "aaa"
    end
  end
end
