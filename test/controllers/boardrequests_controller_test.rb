# frozen_string_literal: true

require 'test_helper'

class BoardrequestsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get boardrequests_create_url
    assert_response :success
  end
end
