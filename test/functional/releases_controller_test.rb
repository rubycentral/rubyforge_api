require File.dirname(__FILE__) + '/../test_helper'

class ReleasesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
    @package = @group.packages.create(:name => "fiddle")
  end

  test "index action" do
    Release.create(:notes => "foo", :released_by => @user, :package => @package)
    get :index, :group_id => @group.id, :package_id => @group.packages.first.id
    assert_response :success
    assert_match "foo", @response.body
  end
  
  test "create action" do
    assert_difference "Release.count" do
      post :create, :group_id => @group.id, :package_id => @package.id, :release => {:name => "testrelease"}
    end
    assert_equal response_json["name"], "testrelease"
    assert_equal response_json["release_id"], Release.last.id
  end

end
