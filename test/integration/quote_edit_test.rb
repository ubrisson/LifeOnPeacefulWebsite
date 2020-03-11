require 'test_helper'

class QuoteEditTest < ActionDispatch::IntegrationTest
  def setup
    @quote = quotes(:one)
    @admin = users(:admin)
  end

  test 'unsuccessful edit' do
    log_in_as(@admin)
    get edit_quote_path(@quote)
    assert_template 'quotes/edit'
    patch quote_path(@quote), params: { quote: { title: '' } }
    assert_template 'quotes/edit'
    assert_not flash.empty?
    assert_select 'div', text: "Failed to edit ''."
  end

  test 'successful edit' do
    log_in_as(@admin)
    get edit_quote_path(@quote)
    assert_template 'quotes/edit'
    title = 'ExampleTitle'
    author = 'ExampleAuthor'
    link = 'example.org'
    patch quote_path(@quote), params:
        { quote:
              { title: title,
                author: author,
                link: link } }
    assert_not flash.empty?
    assert_redirected_to @quote
    @quote.reload
    assert_equal title, @quote.title
    assert_equal author, @quote.author
  end

  test 'successful redirection to last page' do
    log_in_as(@admin)
    get edit_quote_path(@quote), headers: { 'HTTP_REFERER' => quotes_path }
    patch quote_path(@quote), params:
        { quote:
              { title: 'ExampleTitle',
                author: 'ExampleAuthor',
                link: 'example.org' } }
    assert_redirected_to quotes_path
  end
end
