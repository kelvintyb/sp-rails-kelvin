require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe "POST #create" do
    it "with 2 emails creates a subscription" do
      create_list(:user, 2)
      @first_user = User.first.email
      @second_user = User.second.email

      post :create, params: {requestor: @first_user, target: @second_user}
      expect(User.first.subscribing.first).to eq(User.second)
      expect(User.second.subscribers.first).to eq(User.first)
    end
  end

  describe "GET #show" do
    it "shows all emails that can receive updates from the given sender" do
      create_list(:user, 5)
      @first_user = User.first
      @second_user = User.second
      @third_user = User.third
      @fourth_user = User.fourth
      @fifth_user = User.fifth

      @first_user.friend_users << @second_user
      @second_user.block(@first_user)
      @first_user.friend_users << @third_user
      @fifth_user.subscribe_to(@first_user)

      get :show, params: {sender: @first_user.email, text: "Hello World! #{@fourth_user.email}"}
      json = JSON.parse(response.body)
      expect(json["recipients"].include?(@third_user.email)).to eq(true)
      expect(json["recipients"].include?(@fourth_user.email)).to eq(true)
      expect(json["recipients"].include?(@fifth_user.email)).to eq(true)
    end
  end
end
