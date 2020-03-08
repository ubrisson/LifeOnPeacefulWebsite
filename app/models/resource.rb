class Resource < ApplicationRecord
  acts_as_taggable
  scope :only_public, -> { where(public: true) }
  scope :with_tags, -> { preload(:tags) }
  scoped_search on: %i[title author description]
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 144 }
  validates :author, presence: true, length: { maximum: 120 }
  validates :description, presence: true, allow_blank: true
  validates :link, presence: true, allow_blank: true, length: { maximum: 120 }
  validates :public, inclusion: { in: [true, false] }
end