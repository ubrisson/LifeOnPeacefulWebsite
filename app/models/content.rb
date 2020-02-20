class Content < ApplicationRecord
  self.inheritance_column = nil

  acts_as_taggable

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 120 }

  validates :body, presence: true

  validates :type, presence: true, inclusion: { in: %w[post quote]}

  validates :author, presence: true, if: :quote?
  validates :source, presence: true, if: :quote?

  def quote?
    type == 'quote'
  end

end
