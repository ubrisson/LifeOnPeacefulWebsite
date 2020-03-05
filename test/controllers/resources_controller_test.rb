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
    assert_select 'a', text: 'Example_tag'
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

  # region before filter redirection tests

  test 'should redirect create when not logged in' do
    post resources_path, params:
        { resource:
             { title: 'exampleTitle',
               link: 'example.org',
               public: false } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect create when logged in as a non-admin' do
    log_in_as(@not_admin)
    post resources_path, params:
        { resource:
             { title: 'exampleTitle',
               link: 'example.org',
               public: false } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when not logged in' do
    get edit_resource_path(@resource)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when logged in as a non-admin' do
    log_in_as(@not_admin)
    get edit_resource_path(@resource)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when not logged in' do
    patch resource_path(@resource), params: { resource: { title: @resource.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as a non-admin' do
    log_in_as(@not_admin)
    patch resource_path(@resource), params: { resource: { title: @resource.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Resource.count' do
      delete resource_path(@resource)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@not_admin)
    assert_no_difference 'Resource.count' do
      delete resource_path(@resource)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when not logged in' do
    post resources_import_path,
         params: { json: @resources_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when logged in as a non-admin' do
    log_in_as(@not_admin)
    post resources_import_path,
         params: { json: @resources_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  # endregion

  # region admin actions
  test 'should delete resource' do
    log_in_as(@admin)
    assert_difference 'Resource.count', -1 do
      delete resource_path(@resource), headers: { 'HTTP_REFERER' => resources_path }
    end
    assert_redirected_to resources_path
  end

  test 'should show correct resource' do
    @resource.tag_list = 'example, tag'
    @resource.save
    get resource_path(@resource)
    assert_select 'article', count: 1
    assert_select 'a', text: @resource.title, href: @resource.link
    assert_select 'p', text: @resource.description
    @resource.tag_list.each do |tag|
      assert_select 'a', text: "#{tag.to_s.capitalize}"
    end
    assert_select 'cite', text: "\u{2015} #{@resource.author}"
  end

  test 'should import resources' do
    log_in_as(@admin)
    assert_difference 'Resource.count', 3 do
      post resources_import_path,
           params: { json: @resources_to_import }
    end
    assert_not flash.empty?
    assert_redirected_to resources_path
  end
  # endregion

  test 'should export resources' do
    get resources_export_path
    assert_response :success
  end
end
