require 'test_helper'

class ResourcesEditTest < ActionDispatch::IntegrationTest
  def setup
    @resource = resources(:orange)
    @admin = users(:admin)
  end

  test 'unsuccessful edit' do
    log_in_as(@admin)
    get edit_resource_path(@resource)
    assert_template 'resources/edit'
    patch resource_path(@resource), params: { resource: { title: '' } }
    assert_template 'resources/edit'
    assert_not flash.empty?
    assert_select 'div', text: 'Failed edition.'
  end

  test 'successful edit' do
    log_in_as(@admin)
    get edit_resource_path(@resource)
    assert_template 'resources/edit'
    title = 'ExampleTitle'
    author = 'ExampleAuthor'
    link = 'example.org'
    patch resource_path(@resource), params:
        { resource:
            { title: title,
              author: author,
              link: link } }
    assert_not flash.empty?
    assert_redirected_to @resource
    @resource.reload
    assert_equal title, @resource.title
    assert_equal author, @resource.author
    assert_equal link, @resource.link
  end

  test 'successful redirection to last page' do
    log_in_as(@admin)
    get edit_resource_path(@resource), headers: { 'HTTP_REFERER' => resources_path }
    patch resource_path(@resource), params:
        { resource:
              { title: 'ExampleTitle',
                author: 'ExampleAuthor',
                link: 'example.org' } }
    assert_redirected_to resources_path
  end
end
