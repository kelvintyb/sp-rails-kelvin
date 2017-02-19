require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'with email creates user' do
      expect {
              post :create,
              params: {email: "elon@spacex.com"}
            }.to change(User, :count).by(1)
      expect(User.last.email).to eq("elon@spacex.com")
    end
  end
end
