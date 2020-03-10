require 'test_helper'

class ContentPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get content_pages_index_url
    assert_response :success
  end

end
