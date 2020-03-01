class Post < ApplicationRecord
  has_rich_text :body
  acts_as_taggable
  scope :only_public, -> { where(public: true) }
  scoped_search on: %i[title body]
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 144 }
  validates :body, presence: true
  validates :public, inclusion: { in: [true, false] }


  def form_tags
    str = ''
    tag_list.each do |tag|
      str += tag + ', '
    end
    str
  end
end
