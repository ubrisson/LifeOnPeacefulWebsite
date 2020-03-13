require 'test_helper'

class TikasControllerTest < ActionDispatch::IntegrationTest

  setup do
    @admin = users(:admin)
    @tika = tikas(:one)
  end

  test 'should redirect if not admin' do
    get tikas_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should get index if admin' do
    log_in_as(@admin)
    assert is_logged_in?
    get tikas_url
    assert_response :success
    assert_select 'h2', text: 'Masterlist'
  end

  test 'should create tika' do
    log_in_as(@admin)
    assert is_logged_in?
    assert_difference 'Tika.count', 1 do
      post tikas_url, params: {tika: {title: 'test'}}
    end
    assert_not flash.empty?
    assert_redirected_to tikas_path
  end

  test 'should delete tika' do
    log_in_as(@admin)
    assert is_logged_in?
    assert_difference 'Tika.count', -1 do
      delete tika_path(@tika)
    end
    assert_not flash.empty?
    assert_redirected_to tikas_path
  end

  test 'should update tika' do
    log_in_as(@admin)
    assert is_logged_in?
    patch tika_path(@tika), params: { tika: { title: 'test' } }
    assert_not flash.empty?
    assert_redirected_to tikas_path
    follow_redirect!
    @tika.reload
    assert_equal @tika.title, 'test'
    assert_select 'h3', text: 'test'
  end


end
