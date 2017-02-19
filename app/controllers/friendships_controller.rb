class FriendshipsController < ApplicationController
  def create
    #consider adding conditional here, and checking if emails exist as users in first place - can give error message if 1 or more emails not valid in Users
    @emails = params[:friends]
    if User.where(email: @emails).length != 2
      render json: {
        error: "1 or more of the emails submitted does not exist as a User; check submitted email addresses",
        status: 400
      }, status: :bad_request
    else
      puts @emails
      puts @emails[0]
      puts @emails[0].friends

      @first_user = User.where(email: @emails[0])
      @second_user = User.where(email: @emails[1])
      Friendship.create({user: @first_user, friend_user: @second_user})
      # @first_user.friendships.create({friend_user: @second_user})
      render json: {status: "success"}, status: :ok
    end
  end
end
