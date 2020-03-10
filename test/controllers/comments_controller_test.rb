require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @comment = comments(:one)
    @post = posts(:one)
    @admin = users(:admin)
    @not_admin = users(:not_admin)
  end

  test 'should create comment' do
    assert_difference 'Comment.count', 1 do
      post comments_path params: { post_id: @post.id,
                                   comment: {
                                     name: @comment.name,
                                     body: @comment.body,
                                     public: 0
                                   } },
                         headers: { 'HTTP_REFERER' => post_path(@post) }
    end
    assert_not flash.empty?
    assert_redirected_to post_path(@post)
  end

  test 'should not create comment' do
    assert_no_difference 'Comment.count' do
      post comments_path params: { post_id: @post.id,
                                   comment: {
                                     name: @comment.name,
                                     public: 1
                                   } },
                         headers: { 'HTTP_REFERER' => post_path(@post) }

    end
    assert_not flash.empty?
    assert_redirected_to post_path(@post)
  end

  test 'should update comment' do
    log_in_as(@admin)
    patch comment_url(@comment), params: { post_id: @post.id, comment: { public: 1 } }
    assert_not flash.empty?
    assert_redirected_to post_path(@post)
  end

  test 'should update comment and redirect correctly' do
    log_in_as(@admin)
    patch comment_url(@comment), params: { post_id: @post.id, comment: { public: 1 } },
                                 headers: { 'HTTP_REFERER' => posts_path }
    assert_not flash.empty?
    assert_redirected_to posts_path
  end

  test 'should destroy comment' do
    log_in_as(@admin)
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment), params: { post_id: @post.id }
    end
    assert_not flash.empty?
    assert_redirected_to post_path(@post)
  end

  test 'should redirect update when not logged in' do
    patch comment_path(@comment), params: { post_id: @post.id, comment: { public: 1 } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as a non-admin' do
    log_in_as(@not_admin)
    patch comment_path(@comment), params: { post_id: @post.id, comment: { public: 1 } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Comment.count' do
      delete comment_url(@comment), params: { post_id: @post.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@not_admin)
    assert_no_difference 'Comment.count' do
      delete comment_url(@comment), params: { post_id: @post.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
