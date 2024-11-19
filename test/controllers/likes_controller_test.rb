require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end

  test "should create like" do
    @user = users(:one)
    @post = @user.posts.build(title: "Test Post", body: "This is a test")
    @post.save
    post post_likes_path(@post, Like.new)
    assert @post.likes.count == 1, "Like not created"
  end
end
