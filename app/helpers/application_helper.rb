module ApplicationHelper
  def full_title(page_title)
    base_title = "GOOW"
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end
