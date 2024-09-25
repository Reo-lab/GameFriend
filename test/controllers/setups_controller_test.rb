# frozen_string_literal: true

require 'test_helper'

class SetupsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get setups_index_url
    assert_response :success
  end

  test 'should get show' do
    get setups_show_url
    assert_response :success
  end

  test 'should get new' do
    get setups_new_url
    assert_response :success
  end

  test 'should get edit' do
    get setups_edit_url
    assert_response :success
  end

  test 'should get create' do
    get setups_create_url
    assert_response :success
  end

  test 'should get update' do
    get setups_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get setups_destroy_url
    assert_response :success
  end
end
