require 'rails_helper'

RSpec.describe BlockadesController, type: :controller do
  describe "POST #create" do
    it "with 2 emails creates a blockade" do
      create_list(:user, 2)
      @first_user = User.first.email
      @second_user = User.second.email

      post :create, params: {requestor: @first_user, target: @second_user}
      expect(User.first.blocking.first).to eq(User.second)
      expect(User.second.blockers.first).to eq(User.first)
    end
  end
end
