# frozen_string_literal: true

module ApplicationHelper
  def alert_class_for(key)
    case key
    when 'notice'
      'success'
    when 'alert'
      'danger'
    else
      'info'
    end
  end
end
