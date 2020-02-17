# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Life on Peaceful'
  end

  test 'should get home' do
    get root_path
    assert_response :success
    assert_select 'title', @base_title.to_s
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', "About | #{@base_title}"
  end
end
