# frozen_string_literal: true

class UserObserver < ActiveRecord::Observer
  def after_create(user)
    if user.status == 'actived'
      UserMailerWorker.perform_async(user.id)
    end
  end

  def after_save(user)
    if user.status_before_last_save == 'pending' && user.status == 'actived'
      UserMailerWorker.perform_async(user.id)
    end
  end
end
