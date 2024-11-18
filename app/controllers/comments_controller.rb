class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to post_path(@post)
    else
      flash[:error] = "Comment could not be saved"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end
end
