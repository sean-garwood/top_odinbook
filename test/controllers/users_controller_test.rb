require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get discover" do
    create_and_sign_in_user
    get discover_path
    assert_response :success
  end

  test "discover should list all users except self" do
    @count = User.count - 1
    sign_in users(:one)
    get discover_path
    assert_select ".profile-banner", @count
  end

  test "discover should list buttons to follow users" do
    sign_in users(:one)
    get discover_path
    assert_select "form[action=?]", follow_requests_path
  end

  test "list of users should display username, not email" do
    sign_in users(:one)
    assert users(:one).email
    get discover_path
    assert_select ".profile-banner", text: users(:two).name
    assert_select ".profile-banner", text: users(:two).email, count: 0
  end
end
