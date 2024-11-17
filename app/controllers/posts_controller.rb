class PostsController < ApplicationController
  before_action :check_if_already_liked, only: :like
  def index
    # code to list all posts
    @posts = Post.all
  end

  def show
    # code to show a single post
    @post = Post.find(params[:id])
  end

  def new
    # code to display form for a new post
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # display success
      flash[:notice] = "Post was created successfully."
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # code to display form for editing a post
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    Rails.logger.debug { "\e[1;31m#{@post.inspect}\e[0m" }
    @post.destroy
    redirect_to root_path, status: :see_other
  end

  def like
    @post = Post.find(params[:id])
    @like.save
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :author_id)
    end

    def check_if_already_liked
    @like = current_user.likes.build(post: @post)
      if current_user.likes.include?(@like)
        flash[:notice] = "You already liked this post."
      end
    end
end
