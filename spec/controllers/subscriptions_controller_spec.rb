require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe "POST #create" do
    it "with 2 emails creates a subscription" do
      create_list(:user, 2)
      @first_user = User.first
      @second_user = User.second

      post :create, params: {requestor: @first_user, target: @second_user}
      expect(User.first.subscribed_to.first).to eq(User.second)
      expect(User.second.subscribers.first).to eq(User.first)
    end
  end

  describe "GET #show" do
    it "shows all emails that can receive updates from the given sender" do
      create_list(:user, 4)
      @first_user = User.first.email
      @second_user = User.second.email
      @third_user = User.third.email
      @fourth_user = User.fourth.email

      @friends = []
      @friends << @first_user
      @friends << @second_user
      post "/friendships", params: {friends: @friends}

      @friends = []
      @friends << @first_user
      @friends << @third_user
      post "/friendships", params: {friends: @friends}

      post "/blockades", params: {requestor: @first_user, target: @second_user}

      get :show, params: {sender: @first_user, text: "Hello World! #{@fourth_user}"}
      json = JSON.parse(response.body)
      expect(json["recipients"][0]).to eq(@third_user)
      expect(json["recipients"][1]).to eq(@fourth_user)
    end
  end
end
