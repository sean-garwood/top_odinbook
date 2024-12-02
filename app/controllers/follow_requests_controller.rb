class FollowRequestsController < ApplicationController
  include ApplicationHelper
  before_action -> { @follow_request = FollowRequest.find(params[:id]) }, only: %i[accept destroy reject]

  def index
    @sent = FollowRequest.pending.where(sender: current_user).includes(recipient: :profile)
    @received = FollowRequest.pending.where(recipient: current_user).includes(sender: :profile)
  end

  def accept
    @follow_request.accepted!
    redirect_to root_path, notice: "Follow request accepted."
  end

  def create
    @follow_request = current_user.sent_follow_requests.build(follow_request_params)
    if @follow_request.save
      redirect_to root_path, notice: "Follow request sent."
    else
      redirect_to root_path, alert: "Failed to send follow request."
    end
  end

  def destroy
    begin
      @follow_request.destroy
      redirect_to root_path, notice: "Follow request cancelled."
    rescue ActiveRecord::RecordNotFound
      log_error([ params, follow_request_params ], "destroy")
      redirect_to root_path, alert: "Failed to cancel follow request."
    end
  end

  def edit
    @follow_request = FollowRequest.find(params[:id])
  end

  def new
    @follow_request = FollowRequest.new
  end

  def reject
    @follow_request.rejected!
    redirect_to root_path, notice: "Follow request rejected."
  end

  private
    def follow_request_params
      params.require(:follow_request).permit(:recipient_id, :sender_id)
    end
end
