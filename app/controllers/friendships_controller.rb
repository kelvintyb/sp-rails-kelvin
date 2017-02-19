class FriendshipsController < ApplicationController
  def create
    @emails = params[:friends]
    if User.where(email: @emails).length != 2
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    else
      @first_user = User.find_by(email: @emails[0])
      @second_user = User.find_by(email: @emails[1])

      @first_user.friend_users << @second_user
      render json: {status: "success"}, status: :ok
    end
  end

  def show
    if !User.exists?(email: params[:email])
      render json: {
        error: "No users exist with the submitted email; check submitted email address",
        status: 400
      }, status: :bad_request
    else
      @target_user = User.find_by(email: params[:email])
      @target_friends = @target_user.friend_users.map(&:email)
      @count = @target_friends.length
      render json: {
        status: "success",
        friends: @target_friends,
        count: @count
      }, status: :ok
  end

  def show_common
  end
end
