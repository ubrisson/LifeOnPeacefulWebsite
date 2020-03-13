require 'test_helper'

class TikasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tikas_index_url
    assert_response :success
  end

  test "should get create" do
    get tikas_create_url
    assert_response :success
  end

  test "should get update" do
    get tikas_update_url
    assert_response :success
  end

  test "should get delete" do
    get tikas_delete_url
    assert_response :success
  end

end
