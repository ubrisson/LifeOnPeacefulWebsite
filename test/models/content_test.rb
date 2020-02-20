require 'test_helper'

class ContentTest < ActiveSupport::TestCase

  def setup
    # This code is not idiomatically correct.
    @content = Content.new(body: "Lorem ipsum", title:"test")
  end
  test "should be valid" do
    assert @content.valid?
  end

  test "title should be present" do
    @content.title = nil
    assert_not @content.valid?
  end

  test "content should be present" do
    @content.content = " "
    assert_not @content.valid?
  end

  test "order should be most recent first" do
    assert_equal contents(:most_recent), contents.first
  end

  test "type should be post or quote" do
    @content.type = nil
    assert_not @content.valid?
  end

end
