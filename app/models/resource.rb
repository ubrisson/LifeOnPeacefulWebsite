class Resource < ApplicationRecord
  acts_as_taggable
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 144 }
  validates :author, presence: true, length: { maximum: 120 }
  validates :description, presence: true, allow_blank: true
  validates :link, presence: true, allow_blank: true, length: { maximum: 120 }

  # TODO Validate and test publication date ?
  # TODO Validate and test link url
end