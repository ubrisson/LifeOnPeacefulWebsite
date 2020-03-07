class Quote < ApplicationRecord
  acts_as_taggable
  scope :only_public, -> { where(public: true) }
  scoped_search on: %i[title author body commentary]
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 144 }
  validates :author, presence: true, length: { maximum: 120 }
  validates :source, presence: true, length: { maximum: 120 }
  validates :body, presence: true
  validates :commentary, presence: true, allow_blank: true
  validates :public, inclusion: { in: [true, false] }
end
