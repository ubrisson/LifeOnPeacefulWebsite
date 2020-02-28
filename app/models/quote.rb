class Quote < ApplicationRecord
  acts_as_taggable
  scope :only_public, -> { where(public: true) }
  scoped_search on: %i[title author description]
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 144 }
  validates :author, presence: true, length: { maximum: 120 }
  validates :source, presence: true, length: { maximum: 120 }
  validates :commentary, presence: true, allow_blank: true
  validates :public, inclusion: { in: [true, false] }

  def form_tags
    str = ''
    tag_list.each do |tag|
      str += tag + ', '
    end
    str
  end
end
