require File.dirname(__FILE__) + '/../test_helper'

class GroupsControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
  end
  
  test "show should work" do
    get :show, :id => @group.id
    assert_response :success
  end
  
end
