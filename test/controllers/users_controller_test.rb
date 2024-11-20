require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    create_and_sign_in_user
    get users_path
    assert_response :success
  end

  test "index should list all users" do
    @count = User.count
    sign_in users(:one)
    get users_path
    # count number of users-container divs
    # assert that the count is equal to the number of users in the database
    assert_select ".users-container", @count
  end
end
