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

  describe "GET #show" do
    it "shows all friends for a given email" do
      create_list(:user, 2)
      @friends = []
      @friends << User.first.email
      @friends << User.last.email

      post :create, params: {friends: @friends}
      get :show, params: {friends: User.first.email}
      json = JSON.parse(response.body)
      expect(json["friends"][0]).to eq(User.last.email)
      expect(json["count"]).to eq(1)
    end
  end

  describe "GET #show_common" do
    it "shows emails of common friends between two Users" do
      create_list(:user, 3)
      @first_user = User.first
      @last_user = User.last
      @common_friend = User.second

      @friends = []
      @friends << @first_user.email
      @friends << @common_friend.email
      post :create, params: {friends: @friends}

      @friends = []
      @friends << @second_user.email
      @friends << @common_friend.email
      post :create, params: {friends: @friends}

      @compare_friends = [@first_user.email, @second_user.email]
      get :show_common, params: {friends: @compare_friends}
      json = JSON.parse(response.body)
      expect(json["friends"][0]).to eq(@common_friend.email)
      expect(json["count"]).to eq(1)
    end
  end

end
