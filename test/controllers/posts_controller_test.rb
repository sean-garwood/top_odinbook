require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @users = users
    @users.each do |user|
      @user = user
      sign_in @user
    end
  end
  # route testing
  test "should get new" do
    get new_post_path
    assert_response :success, "Failed to get new post path\n #{response.body}"
  end

  test "should get show" do
    get post_path(posts(:one))
    assert_response :success, "Failed to get show post path"
  end

  test "should get edit" do
    get edit_post_path(posts(:one))
    assert_response :success, "Failed to get edit post path"
  end

  test "should get index" do
    get posts_path
    assert_response :success, "Failed to get index post path"
  end

  test "should create post" do
    @author = users(:one)
    @post = @author.posts.build(title: "Test Post", body: "This is a test")
    post posts_path, params: { post: { title: @post.title, body: @post.body } }
    assert_response :redirect, "Failed to create post"
  end

  test "should show post" do
    get post_path(posts(:one))
    assert_response :success, "Failed to show post"
  end

  test "user can like post" do
    @post = posts(:one)
    post like_post_path(@post)
    assert_response :success, "Failed to like post"
  end

  test "should destroy post" do
    @post = posts(:one)
    delete post_path(@post)
    assert_response :redirect, "Failed to destroy post"
  end
end
