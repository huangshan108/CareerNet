require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get student" do
    get :student
    assert_response :success
  end

end
