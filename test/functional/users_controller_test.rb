require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    setup_seed_data
    @user = setup_user_and_basic_auth_for_user
  end
  
  test "show should work" do
    get :show, :id => @user.id
    assert_response :success
  end
  
end
