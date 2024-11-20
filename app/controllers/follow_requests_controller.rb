class FollowRequestsController < ApplicationController
  before_action -> { @follow_request = FollowRequest.find(params[:id]) }, except: :create

  def create
    recipient = User.find(follow_request_params[:recipient_id])
    @follow_request = current_user.follow_requests.build(recipient: recipient)
    if @follow_request.save
      redirect_to root_path, notice: "Follow request sent."
    else
      redirect_to root_path, alert: "Failed to send follow request: #{follow_request.errors.full_messages.join(", ")}"
    end
  end

  def accept
    @follow_request.accepted!
    redirect_to root_path, notice: "Follow request accepted."
  end

  def destroy
    @follow_request.destroy
    redirect_to root_path, notice: "Follow request canceled."
  end

  def reject
    @follow_request.rejected!
    redirect_to root_path, notice: "Follow request rejected."
  end

  private
    def follow_request_params
      params.require(:follow_request).permit(:recipient_id)
    end
end
