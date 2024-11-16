class PostsController < ApplicationController
  def index
    # code to list all posts
    # TODO: scope by own posts and followed users' (leaders) posts
  end

  def show
    # code to show a single post
    @post = Post.find(params[:id])
  end

  def new
    # code to display form for a new post
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # code to display form for editing a post
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # code to delete a post
  end

  def like
    @post = Post.find(params[:id])
    @like = current_user.likes.build(post: @post)
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
