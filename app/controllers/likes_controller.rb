class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      flash[:notice] = "You liked this post."
    else
      flash[:alert] = "Failed to like post."
    end
  end

  # def destroy
  #   # destroy like
  # end
end
