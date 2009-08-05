require File.dirname(__FILE__) + '/../test_helper'

class ReleasesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
    @package = @group.packages.create(:name => "fiddle")
  end

  test "index action" do
    Release.create(:notes => "foo", :release_date => "2009-08-05 00:37", :released_by => @user, :package => @package)
    get :index, :group_id => @group.id, :package_id => @group.packages.first.id
    assert_response :success
    assert_match "foo", @response.body
  end
  
  test "create action" do
    assert_difference "Release.count" do
      post :create, :group_id => @group.id, :package_id => @package.id, :release => {:release_date => "2009-08-05 00:37", :name => "testrelease"}
    end
    assert_response :success
    assert_equal response_json["release_date"], "2009-08-05 00:37:00"
    assert_equal response_json["name"], "testrelease"
    assert_equal response_json["release_id"], Release.last.id
  end

end
