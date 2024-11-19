class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      flash[:notice] = "You liked this post."
    else
      flash[:alert] = "Failed to like post."
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post: @post, user: current_user)
    if @like.destroy
      flash[:notice] = "You unliked this post."
    else
      flash[:alert] = "Failed to unlike post: #{like.errors.full_messages.join(", ")}"
    end
    redirect_to post_path(@post)
  end
end
