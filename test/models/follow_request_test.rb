require "test_helper"

class FollowRequestTest < ActiveSupport::TestCase
  setup do
    # sign in users in follow_requests.yml fixtures
    @user_one = users(:one)
    @user_two = users(:two)
    sign_in @user_one
    sign_in @user_two
  end
  test "new request has status pending" do
    follow_request = follow_requests(:one)
    assert follow_request.pending?
  end

  test "accepted request has status accepted" do
    follow_request = follow_requests(:two)
    follow_request.accepted!
    assert follow_request.accepted?
  end

  test "can't follow self" do
    assert_not follow_requests(:self_request).valid?, "Can follow self"
  end

  test "can't send duplicate request" do
    assert_not_nil follow_requests(:one)
    assert_not follow_requests(:duplicate_request).valid?, "Can send duplicate request"
  end
end
