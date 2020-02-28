require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @not_admin = users(:not_admin)
    @quote = quotes(:one)
    @quotes_to_import = fixture_file_upload('files/quotes_to_import.json',
                                               'application/json')
  end

  test 'should get index' do
    get quotes_url
    assert_response :success
  end

  test 'should show quote' do
    get quote_url(@quote)
    assert_response :success
  end

  # region admin action
  test 'should get new' do
    log_in_as(@admin)
    get new_quote_url
    assert_response :success
  end

  test 'should create quote' do
    log_in_as(@admin)
    assert_difference 'Quote.count', 1 do
      post quotes_url, params: { quote: { author: @quote.author,
                                          body: @quote.body,
                                          commentary: @quote.commentary,
                                          public: @quote.public,
                                          source: @quote.source,
                                          title: @quote.title } }
    end
    assert_redirected_to quotes_path
  end

  test 'should get edit' do
    log_in_as(@admin)
    get edit_quote_url(@quote)
    assert_response :success
  end

  test 'should update quote' do
    log_in_as(@admin)
    patch quote_url(@quote), params: { quote: { author: @quote.author,
                                                body: @quote.body,
                                                commentary: @quote.commentary,
                                                public: @quote.public,
                                                source: @quote.source,
                                                title: @quote.title } }
    assert_redirected_to edit_quote_path(@quote)
  end

  test 'should destroy quote' do
    log_in_as(@admin)
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote)
    end
    assert_redirected_to quotes_url
  end
end
