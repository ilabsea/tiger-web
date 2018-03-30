module ApplicationHelper

  def alert_class_for(key)
    case key
    when "notice"
      return "success"
    when "alert"
      return "danger"
    else
      return "info"
    end
  end
end
