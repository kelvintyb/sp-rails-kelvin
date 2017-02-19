class BlockadesController < ApplicationController
  def create
    create_list(:user, 2)
    @first_user = User.first
    @second_user = User.second

    post :create, params: {requestor: @first_user, target: @second_user}
    expect(User.first.blocking.first).to eq(User.second)
    expect(User.second.blocked_by.first).to eq(User.first)
  end
end
