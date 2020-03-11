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
    assert_redirected_to quote_path(@quote)
  end

  test 'should destroy quote' do
    log_in_as(@admin)
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote)
    end
    assert_redirected_to quotes_url
  end

  test 'should import quotes' do
    log_in_as(@admin)
    assert_difference 'Quote.count', 3 do
      post quotes_import_path,
           params: { json: @quotes_to_import }
    end
    assert_not flash.empty?
    assert_redirected_to quotes_path
  end

  test 'should not create with invalid information' do
    log_in_as(@admin)
    assert is_logged_in?
    assert_no_difference 'Quote.count' do
      post quotes_path, params: { quote: { author: @quote.author,
                                           commentary: @quote.commentary,
                                           source: @quote.source,
                                           title: @quote.title } }
      assert_redirected_to quotes_path
      assert_not flash.empty?
      assert_select 'h3', text: @quote.title, count: 0
    end
  end

  test 'should not update with invalid information' do
    log_in_as(@admin)
    assert is_logged_in?
    patch quote_url(@quote), params: { quote: { body: '' } }
    assert_template 'edit'
    assert_not flash.empty?
  end
  # endregion

  # region search and tags
  test 'should get tagged quote' do
    @quote.tag_list = 'example_tag'
    @quote.save
    get quotes_path, params: { tag: 'example_tag' }
    assert_select 'a', text: 'Example_tag', count: 2
    assert_select 'article', count: 1
  end

  test 'should get searchable quote' do
    get quotes_path, params: { q: 'orange' }
    assert_select 'article', count: 1
  end

  test 'should get tagged and searchable quote' do
    not_orange = quotes(:two)
    not_orange.tag_list = 'orange'
    not_orange.save
    get quotes_path, params: { q: 'orange' }
    assert_select 'article', count: 2
  end
  # endregion

  # region before filter redirection tests
  test 'should redirect new when not logged in' do
    get new_quote_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect new when logged in as a non-admin' do
    log_in_as(@not_admin)
    get new_quote_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect create when not logged in' do
    post quotes_path, params: { quote: { author: @quote.author,
                                         body: @quote.body,
                                         commentary: @quote.commentary,
                                         public: @quote.public,
                                         source: @quote.source,
                                         title: @quote.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect create when logged in as a non-admin' do
    log_in_as(@not_admin)
    post quotes_path, params: { quote: { author: @quote.author,
                                         body: @quote.body,
                                         commentary: @quote.commentary,
                                         public: @quote.public,
                                         source: @quote.source,
                                         title: @quote.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when not logged in' do
    get edit_quote_path(@quote)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect edit when logged in as a non-admin' do
    log_in_as(@not_admin)
    get edit_quote_path(@quote)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when not logged in' do
    patch quote_path(@quote), params: { quote: { title: @quote.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as a non-admin' do
    log_in_as(@not_admin)
    patch quote_path(@quote), params: { quote: { title: @quote.title } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Quote.count' do
      delete quote_path(@quote)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@not_admin)
    assert_no_difference 'Quote.count' do
      delete quote_path(@quote)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when not logged in' do
    post quotes_import_path,
         params: { json: @quotes_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect import when logged in as a non-admin' do
    log_in_as(@not_admin)
    post quotes_import_path,
         params: { json: @quotes_to_import }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  # endregion

  test 'should export quotes' do
    get quotes_export_path
    assert_response :success
  end
end
