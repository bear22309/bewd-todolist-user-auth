require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'must belong to a user' do
    expect {
      user = FactoryBot.create(:user)
      Session.create!(user: user)
    }.not_to raise_error
  end

  it 'should automatically generate a new token' do
    user = FactoryBot.create(:user)
    session = user.sessions.create

    expect(session.token).not_to be_nil
  end
end

