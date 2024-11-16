class PostsController < ApplicationController
  def index
    # code to list all posts
  end

  def show
    # code to show a single post
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

    # code to create a new post
  end

  def edit
    # code to display form for editing a post
  end

  def update
    # code to update a post
  end

  def destroy
    # code to delete a post
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
