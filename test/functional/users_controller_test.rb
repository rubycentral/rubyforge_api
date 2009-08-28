require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    setup_seed_data_with_group_and_admin_user
  end
  
  test "show should work" do
    get :show, :id => @user.id
    assert_response :success
    assert_equal response_json["user"]["user_name"], @user.user_name
  end
  
  test "index should work" do
    get :groups, :user_id => @user.id
    assert_response :success
    assert_equal response_json.first["group"]["unix_group_name"], @group.unix_group_name
  end
  
end
