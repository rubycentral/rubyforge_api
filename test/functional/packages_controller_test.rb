require File.dirname(__FILE__) + '/../test_helper'

class PackagesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data
    setup_user_and_basic_auth_for_user
    setup_group
    Role.make
    @user.user_group.create(:group => @group, :release_flags => 1, :role_id => Role.first.id)
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
