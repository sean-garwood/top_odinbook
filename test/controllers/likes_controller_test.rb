require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end

  test "should create like" do
    @user = users(:one)
    @post = @user.posts.build(title: "Test Post", body: "This is a test")
    @post.save
    post post_likes_path(@post, @user)
    assert_response :success, "Failed to like post"
  end
end
