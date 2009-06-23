require File.dirname(__FILE__) + '/../test_helper'

class PackagesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
  end

  test "can create package" do
    assert_difference 'Package.count' do
      create_package_via_post
    end
  end
  
  test "index works" do
    create_package_via_post
    get :index, :group_id => Group.first
    assert_equal "apples", JSON.parse(@response.body).first["package"]["name"]
  end
  
  private
  
  def create_package_via_post
    post :create, {:package => {:name => "apples", :status_id => 1}, :group_id => @group.id}
  end
end
