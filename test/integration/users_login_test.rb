# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test 'login with invalid name' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: '', password: 'password' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with invalid password' do
    post login_path, params: { session: {
      name: 'michael',
      password: 'wrongpassword'
    } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test 'login with valid information followed by logout' do
    get '/login'
    assert_equal 200, status
    @user = users(:admin)
    post '/login', params: { session: { name: @user.name,
                                        password: 'password' } }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_equal 200, status
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
  end
end