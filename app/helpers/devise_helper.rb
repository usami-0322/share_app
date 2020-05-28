module DeviseHelper
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

  def current_user?(user)
    user == current_user
  end
end
