require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @admin = users(:admin)
  end

  test 'unsuccessful edit' do
    log_in_as(@admin)
    get edit_post_path(@post)
    assert_template 'posts/edit'
    patch post_path(@post), params: { post: { title: '' } }
    assert_template 'posts/edit'
    assert_not flash.empty?
    assert_select 'div', text: "Failed to edit ''."
  end

  test 'successful edit' do
    log_in_as(@admin)
    title = 'ExampleTitle'
    author = 'ExampleAuthor'
    link = 'example.org'
    patch post_path(@post), params:
        { post:
              { title: title,
                author: author,
                link: link } }
    assert_not flash.empty?
    assert_redirected_to @post
    @post.reload
    assert_equal title, @post.title
  end

  test 'successful redirection to last page' do
    log_in_as(@admin)
    get edit_post_path(@post), headers: { 'HTTP_REFERER' => posts_path }
    patch post_path(@post), params:
        { post:
              { title: 'ExampleTitle',
                author: 'ExampleAuthor',
                link: 'example.org' } }
    assert_redirected_to posts_path
  end
end
