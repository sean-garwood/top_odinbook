class PostsController < ApplicationController
  before_action :authorize, only: [ :edit, :update, :destroy ]

  def index
    @posts = current_user.feed
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
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
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, status: :see_other
  end


  private
    def post_params
      params.require(:post).permit(:title, :body, :author_id)
    end

    def authorize
      # check if the current_user is the post.author
      Rails.logger.debug { "Authorizing user." }
      @post = Post.find(params[:id])
      unless current_user == @post.author
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
      end
      @post
    end
end
