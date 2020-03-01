class Post < ApplicationRecord
  has_rich_text :body
  scope :only_public, -> { where(public: true) }
  scoped_search on: %i[title body]
  default_scope -> { order(created_at: :desc) }
end
