class Tika < ApplicationRecord
  before_save do
    title.downcase!
  end
  has_ancestry
  default_scope -> { order(title: :asc) }
  validates :title, presence: true,
                    length: { maximum: 144 },
                    uniqueness: { case_sensitive: false }
end
