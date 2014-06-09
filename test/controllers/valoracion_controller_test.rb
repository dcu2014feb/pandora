require 'test_helper'

class ValoracionControllerTest < ActionController::TestCase
  test "should get get" do
    get :get
    assert_response :success
  end

  test "should get send" do
    get :send
    assert_response :success
  end

end
