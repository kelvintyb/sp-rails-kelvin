class UsersController < ApplicationController
  def create
    User.create(user_params)
  end

  private
  def user_params
    params.permit(:email)
  end
end
