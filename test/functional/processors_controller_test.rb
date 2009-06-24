require File.dirname(__FILE__) + '/../test_helper'

class ProcessorsControllerTest < ActionController::TestCase
  
  def setup
    setup_seed_data_with_group_and_admin_user
  end

  test "index should work" do
    Processor.make
    get :index
    assert_response :success
    assert_match "i386", @response.body
  end
  
end
