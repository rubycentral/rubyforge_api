require File.dirname(__FILE__) + '/../test_helper'

class FilesControllerTest < ActionController::TestCase
  
  def setup
    setup_seed_data_with_group_and_admin_user
    @package = @group.packages.create!(:name => "fiddle")
    @release = @package.releases.create(:notes => "foo", :released_by => @user)
  end
  
  test "create action" do
    assert_difference "Dir.glob(\"#{@group.group_file_directory}/*\").size" do
      assert_difference 'FrsFile.count' do
        assert_difference "@release.files.count" do
          create_file_with_post
          assert_equal File.read(File.join(@group.group_file_directory, @filename)), @filecontents
          assert_equal FrsFile.last.filename, @filename
          assert_equal FrsFile.last.file_size, File.size(File.join(@group.group_file_directory, @filename))
          assert_equal FrsFile.last.release, @release
          assert_equal FrsFile.last.processor, Processor.first
        end
      end
    end
  end
  
  test "not part of the group" do
    @user.user_group.map(&:destroy)
    assert_no_difference 'FrsFile.count' do
      create_file_with_post
    end
    assert_response :forbidden
  end
  
  test "index action" do
    create_file_with_post
    get :index, :release_id => @release.id
    assert_response :success
    assert_match @release.files.to_json, @response.body
  end
  
  
  def teardown 
    FileUtils.rm_rf @group.group_file_directory
  end
  
  private 
  
  def create_file_with_post
    @filecontents = "Here are the file contents"
    @filename = "test.txt"
    post :create, :group_id => @group.id, :package_id => @package.id, :release_id => @release.id, :contents => @filecontents, :file => {:filename => @filename, :processor_id => Processor.first.id, :type_id => FileType.first.id}
  end

end
