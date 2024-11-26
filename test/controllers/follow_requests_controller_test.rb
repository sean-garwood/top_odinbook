require "test_helper"

class FollowRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    sign_in @user_one
    sign_in @user_two
  end

  test "should accept follow request" do
    @follow_request = follow_requests(:one)
    patch accept_follow_request_path(@follow_request)
    assert_equal "Follow request accepted.", flash[:notice]
  end

  test "should create follow request" do
    @new_user = users(:three)
    sign_in @new_user
    @follow_request = @new_user.pending_sent_follow_requests.build(recipient: @user_one)
    post follow_requests_path, params: { follow_request: { recipient_id: @user_one.id, sender_id: @new_user.id } }
    assert_equal "Follow request sent.", flash[:notice]
  end

  test "should destroy follow request" do
    @follow_request = follow_requests(:one)
    delete follow_request_path(@follow_request)
    assert_equal "Follow request cancelled.", flash[:notice]
  end
  test "should reject follow request" do
    @follow_request = follow_requests(:one)
    patch reject_follow_request_path(@follow_request)
    assert_equal "Follow request rejected.", flash[:notice]
  end
end
