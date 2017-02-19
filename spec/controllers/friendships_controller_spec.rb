require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  describe "POST #create" do
    it "with 2 emails creates a friendship" do
      create_list(:user, 2)
      @friends = []
      @friends << User.first.email
      @friends << User.last.email

      post :create, params: {friends: @friends}
      expect(User.first.friend_users.first).to eq(User.last)
      expect(User.last.friend_users.first).to eq(User.first)
    end
  end
end
