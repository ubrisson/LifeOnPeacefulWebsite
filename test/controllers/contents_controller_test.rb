require 'test_helper'

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contents_new_url
    assert_response :success
  end

  test "should get posts" do
    get posts_path
    assert_response :success
  end

  test "should get quotes" do
    get quotes_path
    assert_response :success
  end

end
