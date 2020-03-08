class Post < ApplicationRecord
  has_rich_text :body
  acts_as_taggable
  scope :with_tags, -> { preload(:tags) }
  scope :only_public, -> { where(public: true) }
  scoped_search on: %i[title summary]
  scoped_search relation: :rich_text_body, on: :body
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 144 }
  validates :body, presence: true, allow_blank: true
  validates :public, inclusion: { in: [true, false] }
  validates :summary, presence: true, if: -> { public? }
end
