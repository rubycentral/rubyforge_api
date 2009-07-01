ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def response_json
    JSON.parse(@response.body)
  end
  
  setup { Sham.reset }
  
  def setup_seed_data_with_group_and_admin_user
    setup_seed_data
    setup_user_and_basic_auth_for_user
    setup_group
    Role.make
    @user.user_group.create(:group => @group, :release_flags => 1, :role_id => Role.first.id)
  end
  
  def setup_seed_data
    FrsStatus.add FrsStatus::ACTIVE, "Active"
    FileType.add 9999, "Other"
    CountryCode.add 'Chad', 'TD'
    License.make
    Processor.make
    SupportedLanguage.make
    UserType.make
  end
  
  def setup_basic_auth_for(user)
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("#{user.user_name}:secret")
  end
  
  def setup_group
    @group = Group.make
  end
  
  def setup_user_and_basic_auth_for_user
    @user = User.make
    setup_basic_auth_for @user
    @user
  end
end
