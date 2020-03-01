require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'form_tags should return tags between comas' do
    post = posts(:one)
    post.tag_list = "full, resource, example, tag"
    post.save
    assert_equal 'full, resource, example, tag, ', posts(:one).form_tags
  end
end
