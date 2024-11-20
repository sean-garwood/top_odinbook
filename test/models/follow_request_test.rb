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
    follow_request = @user_one.follow_requests.build(recipient: @user_two)
    assert follow_request.pending?
  end

  test "accepted request has status accepted" do
    follow_request = follow_requests(:one)
    follow_request.accepted!
    assert follow_request.accepted?
  end

  test "rejected request has status rejected" do
    follow_request = follow_requests(:two)
    follow_request.rejected!
    assert follow_request.rejected?
  end

  test "can't follow self" do
    assert_not follow_requests(:self_request).valid?, "Can follow self"
  end
end
