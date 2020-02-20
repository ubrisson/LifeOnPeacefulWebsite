require 'test_helper'

class ContentTest < ActiveSupport::TestCase

  def setup
    @content = Content.new(body: "Lorem ipsum", title:"test", type:"post")
  end
  test "post should be valid" do
    assert @content.valid?
  end

  test "quote should be valid" do
    @content.type = "quote"
    @content.source = "example.org"
    @content.author = "ego"
    assert @content.valid?
  end

  test "title should be present" do
    @content.title = nil
    assert_not @content.valid?
  end

  test "content should be present" do
    @content.body = " "
    assert_not @content.valid?
  end

  test "order should be most recent first" do
    assert_equal contents(:most_recent), Content.first
  end

  test "type should be present" do
    @content.type = nil
    assert_not @content.valid?
  end

  test "quotes should have author" do
    @content.type = "quote"
    @content.author = nil
    assert_not @content.valid?
  end

  test "quotes should have source" do
    @content.type = "quote"
    @content.source = nil
    assert_not @content.valid?
  end

end
