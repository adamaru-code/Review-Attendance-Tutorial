module ApplicationHelper
  
  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "AttendanceApp"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title # 文字列を連結して返す
    end
  end
end