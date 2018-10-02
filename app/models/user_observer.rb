# frozen_string_literal: true

class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailerWorker.perform_async(user.id) if user.status == 'actived'
  end

  def after_save(user)
    return unless user.status_before_last_save == 'pending' && user.status == 'actived'

    UserMailerWorker.perform_async(user.id)
  end
end
