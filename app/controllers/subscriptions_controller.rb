class SubscriptionsController < ApplicationController
  def create
    if !User.exists?(email: params[:requestor]) || !User.exists?(email: params[:target])
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    else
      @requestor = User.find_by(email: params[:requestor])
      @target = User.find_by(email: params[:target])
      @requestor.subscribe_to(@target)
      render json: {status: "success"}, status: :ok
    end
  end

  def show
    @sender = User.find_by(email: params[:sender])
    @recipients = []

    @subscribers = @sender.subscribers.map(&:email)
    @friends = @sender.friend_users.map(&:email)
    @mentions = params[:text].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)
    @blockers = @sender.blockers.map(&:email)

    @recipients.push(*@subscribers)
    @recipients.push(*@friends)
    @recipients.push(*@mentions)
    @recipients = @recipients.uniq.delete_if {|email| @blockers.include?(email)}
    render json: {status: "success", recipients: @recipients}, status: :ok
  end
end
