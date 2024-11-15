class FollowRequestsController < ApplicationController
  def new
    @follow_request = FollowRequest.new
  end

  def create
    @follow_request = FollowRequest.new(follow_request_params)
    if @follow_request.save
      redirect_to @follow_request
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
  end

  private
    def follow_request_params
      params.require(:follow_request).permit(:leader_id, :follower_id)
    end
end
