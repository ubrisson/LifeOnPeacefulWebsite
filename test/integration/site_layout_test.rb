# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'navigation_links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', resume_path
    assert_select 'a[href=?]', resources_path
  end
end
