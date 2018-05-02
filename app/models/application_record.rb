# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  strip_attributes

  def self.update_order!(ids, field)
    ids.each_with_index do |id, index|
      where(primary_key.to_s => id).update_all(field.to_s => index + 1)
    end
  end
end
