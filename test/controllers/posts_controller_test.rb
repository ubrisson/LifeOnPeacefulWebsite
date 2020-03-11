require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @not_admin = users(:not_admin)
    @post = posts(:one)
    # @posts_to_import = fixture_file_upload('files/posts_to_import.json',
    #                                         'application/json')
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  # region admin action
  test 'should get new' do
    log_in_as(@admin)
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    log_in_as(@admin)
    assert_difference 'Post.count', 1 do
      post posts_url, params: { post: { title: @post.title,
                                        public: @post.public,
                                        summary: @post.summary  } }
    end
    assert_redirected_to posts_path
  end

  test 'should get edit' do
    log_in_as(@admin)
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    log_in_as(@admin)
    patch post_url(@post), params: { post: { title: @post.title, public: @post.public } }
    assert_redirected_to post_path(@post)
  end

  test 'should destroy post' do
    log_in_as(@admin)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end

  # TODO. Find a way to test post import (blobs and action_text fixtures)
  # test 'should import posts' do
  #   log_in_as(@admin)
  #   assert_difference 'Post.count', 3 do
  #     post posts_import_path,
  #          params: { json: @posts_to_import }
  #   end
  #   assert_not flash.empty?
  #   assert_redirected_to posts_path
  # end

  test 'should not create with invalid information' do
    log_in_as(@admin)
    assert is_logged_in?
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: @post.title } }
      assert_redirected_to posts_path
      assert_not flash.empty?
      assert_select 'h3', text: @post.title, count: 0
    end
  end

  test 'should not update with invalid information' do
    log_in_as(@admin)
    assert is_logged_in?
    patch post_url(@post), params: { post: { title: '' } }
    assert_template 'edit'
    assert_not flash.empty?
  end
  # endregion

  # region search and tags
  test 'should get tagged post' do
    @post.tag_list = 'example_tag'
    @post.save
    get posts_path, params: { tag: 'example_tag' }
    assert_select 'a', text: 'Example_tag'
    assert_select 'article', count: 1
  end

  test 'should get searchable post' do
    get posts_path, params: { q: 'orange' }
    assert_select 'article', count: 1
  end

  test 'should get tagged and searchable post' do
    not_orange = posts(:two)
    not_orange.tag_list = 'orange'
    not_orange.save
    get posts_path, params: { q: 'orange' }
    assert_select 'article', count: 2
  end
  # endregion

  # region before filter redirection tests
  test 'should redirect new when not logged in' do
    get new_post_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect new when logged in as a non-admin' do
    log_in_as(@not_admin)
    get new_post_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect create when not logged in' do
    post posts_path, params: { post: { title: @post.title, public:false } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect create when logged in as a non-admin' do
    log_in_as(@not_admin)
    post posts_path, params: { post: { title: @post.title, public:false } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when not logged in' do
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when logged in as a non-admin' do
    log_in_as(@not_admin)
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when not logged in' do
    patch post_path(@post), params: { post: { title: @post.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as a non-admin' do
    log_in_as(@not_admin)
    patch post_path(@post), params: { post: { title: @post.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@not_admin)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when not logged in' do
    post posts_import_path,
         params: { json: @posts_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when logged in as a non-admin' do
    log_in_as(@not_admin)
    post posts_import_path,
         params: { json: @posts_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  # endregion

  test 'should export posts' do
    get posts_export_path
    assert_response :success
  end
end
