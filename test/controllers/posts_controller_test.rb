require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users = users
    @users.each do |user|
      @user = user
      sign_in @user
    end
  end

  test "should get new" do
    get new_post_path
    assert_response :success, "Failed to get new post path\n #{response.body}"
  end

  test "should get show" do
    get post_path(posts(:one))
    assert_response :success, "Failed to get show post path"
  end

  test "should get edit" do
    @post = @user.posts.create(title: "Test Post", body: "This is a test")
    get edit_post_path(@post)
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

  test "should destroy post" do
    @post = posts(:one)
    delete post_path(@post)
    assert_response :redirect, "Failed to destroy post"
  end

  test "should update post" do
    @post = posts(:one)
    patch post_path(@post), params: { post: { title: "Updated Title", body: "Updated Body" } }
    assert_response :redirect, "Failed to update post"
  end

  test "index should only show posts from self and followed users" do
    get posts_path
    assert_select ".post-container", (
      @user.feed.count + @user.posts.count
    ), "Index page should only show posts from self and followed users"
  end
end
