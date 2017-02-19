require 'rails_helper'

RSpec.describe BlockadesController, type: :controller do
  describe "POST #create" do
    it "with 2 emails creates a blockade" do
      create_list(:user, 2)
      @first_user = User.first
      @second_user = User.second

      post :create, params: {requestor: @first_user, target: @second_user}
      expect(User.first.blocking.first).to eq(User.second)
      expect(User.second.blocked_by.first).to eq(User.first)
    end
  end
end
