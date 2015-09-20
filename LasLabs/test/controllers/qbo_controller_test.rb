require 'test_helper'

class QboControllerTest < ActionController::TestCase
  test "should get authenticate" do
    get :authenticate
    assert_response :success
  end

  test "should get oauth_callback" do
    get :oauth_callback
    assert_response :success
  end

end
