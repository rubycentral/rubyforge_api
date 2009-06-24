require File.dirname(__FILE__) + '/../test_helper'

class ReleasesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
  end

  test "index action" do
    p = @group.packages.create(:name => "fiddle", :status_id => FrsStatus::ACTIVE)
    Release.create(:notes => "foo", :released_by => @user, :package => p, :status_id => FrsStatus::ACTIVE)
    get :index, :group_id => @group.id, :package_id => @group.packages.first.id
    assert_response :success
    assert_match "foo", @response.body
  end

end
