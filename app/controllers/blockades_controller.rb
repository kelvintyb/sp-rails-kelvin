class BlockadesController < ApplicationController
  def create
    if !User.exists?(email: params[:requestor]) || !User.exists?(email: params[:target])
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    else
      @requestor = User.find_by(email: params[:requestor])
      @target = User.find_by(email: params[:target])
      @requestor.block(@target)
      render json: {status: "success"}, status: :ok
    end
  end
end
