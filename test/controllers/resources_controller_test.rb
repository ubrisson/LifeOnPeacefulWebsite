require 'test_helper'

class ResourcesControllerTest < ActionDispatch::IntegrationTest

  test 'should create new post' do
    assert_difference 'Resource.count', 1 do
      title = 'ExampleTitle'
      author = 'ExampleAuthor'
      link = 'example.org'
      post resources_path, params:
          { resource:
               { title: title,
                 author: author,
                 link: link } }
      assert_not flash.empty?
      assert_redirected_to resources_path
    end
  end

  test 'should not create a new post' do
    assert_no_difference 'Resource.count' do
      title = 'ExampleTitle'
      link = 'example.org'
      post resources_path, params:
          { resource:
               { title: title,
                 link: link } }
      assert_not flash.empty?
      assert_redirected_to resources_path
      assert_select 'a', text: title, href: link, count: 0
    end
  end
end
