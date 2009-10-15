require 'test/test_helper'

class StatusControllerTest < ActionController::TestCase

  test "status action doesn't log or need to be authenticated" do
    assert_no_difference 'ApiRequest.count' do
      get :status
      assert_response :ok
    end
  end

end
