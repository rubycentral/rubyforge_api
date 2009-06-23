require File.dirname(__FILE__) + '/../test_helper'

class ReleasesControllerTest < ActionController::TestCase

  def setup
    setup_seed_data_with_group_and_admin_user
  end

  test "index action works" do
    p = @group.packages.create(:name => "fiddle", :status_id => 1)
    Release.create(:notes => "foo", :released_by => @user, :package => p, :status_id => 1)
    get :index, :group_id => @group.id, :package_id => @group.packages.first.id
    assert_response :success
    assert_match "foo", @response.body
  end
end
