require 'test_helper'

class ContentPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_path
    assert_response :success
  end

  test "should get latest" do
    get latest_path
    assert_response :success
  end

end
