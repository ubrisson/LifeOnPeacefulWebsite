require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test 'form_tags should return tags between comas' do
    quote = quotes(:one)
    quote.tag_list = "full, resource, example, tag"
    quote.save
    assert_equal 'full, resource, example, tag, ', quotes(:one).form_tags
  end
end
