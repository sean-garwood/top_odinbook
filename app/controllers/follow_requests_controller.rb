class FollowRequestsController < ApplicationController
  include ApplicationHelper
  def accept
    @follow_request = FollowRequest.find_by(follow_request_params)
    @follow_request.accepted!
    redirect_to root_path, notice: "Follow request accepted."
  end

  def create
    recipient = User.find(follow_request_params[:recipient_id])

    my_logger([ params, follow_request_params, recipient ], :debug)

    @follow_request = recipient.follow_requests.build(sender: current_user)
    if @follow_request.save
      redirect_to root_path, notice: "Follow request sent."
    else
      redirect_to root_path, alert: "Failed to send follow request: #{@follow_request.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @follow_request = FollowRequest.find(follow_request_params)
    begin
      @follow_request.destroy
      redirect_to root_path, notice: "Follow request cancelled."
    rescue ActiveRecord::RecordNotFound
      log_error([ params, follow_request_params ], "destroy")
      redirect_to root_path, alert: "Failed to cancel follow request."
    end
  end

  def received
    @follow_requests =  received_follow_requests
  end

  def reject
    @follow_request.rejected!
    redirect_to root_path, notice: "Follow request rejected."
  end

  def sent
    @follow_requests = sent_follow_requests
  end

  private
    def follow_request_params
      params.require(:follow_request).permit(:recipient_id, :sender_id)
    end

    def received_follow_requests
      FollowRequest.order(:created_at).includes(:recipient, :sender).pending.where(recipient: current_user)
    end

    def sent_follow_requests
      FollowRequest.order(:created_at).includes(:recipient, :sender).pending.where(sender: current_user)
    end
end
