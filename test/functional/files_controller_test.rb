require File.dirname(__FILE__) + '/../test_helper'

class FilesControllerTest < ActionController::TestCase
  
  def setup
    setup_seed_data_with_group_and_admin_user
    @package = @group.packages.create!(:name => "fiddle", :status_id => FrsStatus::ACTIVE)
    @release = @package.releases.create(:notes => "foo", :released_by => @user, :status_id => FrsStatus::ACTIVE)
  end
  
  test "create action" do
    filecontents = "Here are the file contents"
    filename = "test.txt"
    assert_difference "Dir.glob(\"#{@group.group_file_directory}/*\").size" do
      assert_difference 'FrsFile.count' do
        assert_difference "@release.files.count" do
          post :create, :group_id => @group.id, :package_id => @package.id, :release_id => @release.id, :contents => filecontents, :file => {:filename => filename, :processor_id => Processor.first.id, :type_id => FileType.first.id}
        end
      end
    end
    assert_equal File.read(File.join(@group.group_file_directory, "test.txt")), filecontents
  end
  
  def teardown 
    FileUtils.rm_rf @group.group_file_directory
  end

end
