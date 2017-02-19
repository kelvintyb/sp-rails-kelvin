class FriendshipsController < ApplicationController
  def create
    @emails = params[:friends]
    @first_user = User.find_by(email: @emails[0])
    @second_user = User.find_by(email: @emails[1])

    if User.where(email: @emails).size != 2
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    elsif @first_user.blocking?(@second_user) || @second_user.blocking?(@first_user)
      render json: {
        error: "New friend connections cannot be added between these emails due to a block",
        status: 403
      }, status: :forbidden
    else
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
      @target_friends = @target_user.friend_emails
      @count = @target_friends.size
      render json: {
        status: "success",
        friends: @target_friends,
        count: @count
      }, status: :ok
    end
  end

  def show_common
    @emails = params[:friends]
    if User.where(email: @emails).size != 2
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    else
      @first_user_friends = User.find_by(email: @emails[0]).friend_emails
      @second_user_friends = User.find_by(email: @emails[1]).friend_emails

      @common_friends = @first_user_friends & @second_user_friends
      @count = @common_friends.size
      render json: {status: "success", friends: @common_friends, count: @count}, status: :ok
    end
  end
end
