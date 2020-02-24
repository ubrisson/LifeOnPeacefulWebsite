require 'test_helper'

class ResourcesEditTest < ActionDispatch::IntegrationTest
  def setup
    @resource = resources(:orange)
  end

  test 'unsuccessful edit' do
    get edit_resource_path(@resource)
    assert_template 'resources/edit'
    patch resource_path(@resource), params: { resource: { title: 'test' } }
    assert_template 'resources/edit'
    assert_not flash.empty?
  end

  test 'successful edit' do
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
end
