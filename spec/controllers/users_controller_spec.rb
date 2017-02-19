require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'with email creates user' do
      expect {
              post :create,
              email_address: "elon@spacex.com"
            }.to change(User, :count).by(1)
      expect(User.last.email_address).to eq("elon@spacex.com")
    end
  end
end
