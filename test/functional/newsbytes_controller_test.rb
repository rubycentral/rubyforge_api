require File.dirname(__FILE__) + '/../test_helper'

class NewsBytesControllerTest < ActionController::TestCase
  
  def setup 
    setup_seed_data_with_group_and_admin_user
    @user.user_group.first.update_attribute(:admin_flags, 'A')
  end
  
  test "create action" do
    assert_difference 'NewsByte.count' do
      assert_difference 'ForumGroup.count' do
        create_news_byte_via_post
        assert_match /Merry/, NewsByte.last.summary
        assert_match /happy/, NewsByte.last.details
        assert_equal 0, NewsByte.last.is_approved
        assert_equal @user, NewsByte.last.submitted_by
        assert_equal NewsByte.last.forum_group, ForumGroup.last
        assert NewsByte.last.post_date && NewsByte.last.post_date != 0
        assert_match /merry/, ForumGroup.last.forum_name
        assert_match /Merry/, ForumGroup.last.description
        assert_equal 0, ForumGroup.last.allow_anonymous
        assert_equal Group.system_news_group, ForumGroup.last.group
      end
    end
  end
  
  test "unauthorized" do
    @user.user_group.first.update_attribute(:admin_flags, '')
    create_news_byte_via_post
    assert_response :forbidden
  end
   
  private
  
  def create_news_byte_via_post
    post :create, :group_id => @group.id, :news_byte => {:summary => "Merry Christmas!", :details => "And a happy new year to all!"}
  end
  
end
