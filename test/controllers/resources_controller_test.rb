require 'test_helper'

class ResourcesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @not_admin = users(:not_admin)
    @resource = resources(:orange)
    @resources_to_import = fixture_file_upload('files/resources_to_import.json',
                                                    'application/json')
  end

  test 'should create new post' do
    log_in_as(@admin)
    assert_difference 'Resource.count', 1 do
      title = 'ExampleTitle'
      author = 'ExampleAuthor'
      link = 'example.org'
      post resources_path, params:
          { resource:
               { title: title,
                 author: author,
                 link: link,
                 public: false } }
      assert_not flash.empty?
      assert_redirected_to resources_path
    end
  end

  test 'should not create with invalid information' do
    log_in_as(@admin)
    assert is_logged_in?
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

  test 'should get tagged resource' do
    @resource.tag_list = 'example_tag'
    @resource.save
    get resources_path, params: { tag: 'example_tag' }
    assert_select 'a', text: '#example_tag'
  end

  test 'should get searchable resource' do
    get resources_path, params: { q: 'orange' }
    assert_select 'article', count: 1
  end

  test 'should get tagged and searchable resource' do
    @not_orange = resources(:most_recent)
    @not_orange.tag_list = 'orange'
    @not_orange.save
    get resources_path, params: { q: 'orange' }
    assert_select 'article', count: 2
  end
end
