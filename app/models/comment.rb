class Comment < ApplicationRecord
  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  validates :body, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [false] }, on: :create
end
