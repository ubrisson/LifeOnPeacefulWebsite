require 'test_helper'

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contents_new_url
    assert_response :success
  end

  test "should get posts" do
    get contents_posts_url
    assert_response :success
  end

  test "should get quotes" do
    get contents_quotes_url
    assert_response :success
  end

end
