# frozen_string_literal: true

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  def setup
    @resource = Resource.new(author: 'exampleAuthor', title: 'exampleTitle', public: 'false')
    @full_resource = Resource.new(author: 'exampleAuthor', title: 'exampleTitle',
                                  description: 'A very interesting article on examples.',
                                  link: 'http://example.org/exampleArticle',
                                  public: 'true',
                                  tag_list: 'full, resource, example, tag')
  end
  test 'resources should be valid' do
    assert @resource.valid?
    assert @full_resource.valid?
  end

  test 'title should be present' do
    @resource.title = ' '
    assert_not @resource.valid?
  end

  test 'author should be present' do
    @resource.author = ' '
    assert_not @resource.valid?
  end

  test 'order should be most recent first' do
    assert_equal resources(:most_recent), Resource.first
  end
end
