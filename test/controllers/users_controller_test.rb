require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_search" do
    get users_my_search_url
    assert_response :success
  end

end
