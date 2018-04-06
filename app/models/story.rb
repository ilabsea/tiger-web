class Story < ApplicationRecord
  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags
  accepts_nested_attributes_for :tags

  strip_attributes only: [:title, :image]

  def tags=(tag_attributes)
    tag_attributes.each do |title|
      tag = Tag.find_or_create_by(title: title)
      self.tags << tag
    end
  end
end
