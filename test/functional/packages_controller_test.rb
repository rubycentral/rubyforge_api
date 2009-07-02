require File.dirname(__FILE__) + '/../test_helper'

class PackagesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
  end

  test "can create package" do
    assert_difference 'Package.count' do
      create_package_via_post
    end
    assert_equal response_json["package"]["name"], "apples"
    assert_equal response_json["package"]["package_id"], Package.last.id
  end
  
  test "index works" do
    create_package_via_post
    get :index, :group_id => @group
    assert_equal "apples", JSON.parse(@response.body).first["package"]["name"]
  end
  
  test "can destroy package" do
    create_package_via_post
    Package.last.releases.create(:name => "foo", :released_by => User.first)
    assert_difference "Package.count", -1 do
      delete :destroy, :group_id => @group.id, :id => Package.last.id
    end
  end
  
  private
  
  def create_package_via_post
    post :create, {:package => {:name => "apples"}, :group_id => @group.id}
  end
end
