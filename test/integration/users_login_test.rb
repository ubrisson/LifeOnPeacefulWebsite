require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do
    # get the login page
    get '/login'
    assert_equal 200, status
    @user = users(:michael)
    post '/login', params: { session: { name: @user.name,
                                        password: 'password' } }
    assert_redirected_to root_url
    follow_redirect!
    assert_equal 200, status
    assert_select 'h3', text: "Welcome #{@user.name}"
    assert is_logged_in?
  end

end