require "test_helper"

class BlackList::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get black_list_users_index_url
    assert_response :success
  end
end
