# frozen_string_literal: true

require 'test_helper'

class GametitlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get gametitles_index_url
    assert_response :success
  end

  test 'should get show' do
    get gametitles_show_url
    assert_response :success
  end

  test 'should get edit' do
    get gametitles_edit_url
    assert_response :success
  end

  test 'should get new' do
    get gametitles_new_url
    assert_response :success
  end

  test 'should get update' do
    get gametitles_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get gametitles_destroy_url
    assert_response :success
  end
end
