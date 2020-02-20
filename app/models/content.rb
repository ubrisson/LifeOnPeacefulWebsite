class Content < ApplicationRecord
  acts_as_taggable
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 120 }

  validates :body, presence: true, uniqueness: {case_sensitive: false}


end
