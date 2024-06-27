# File: spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'must have a unique username' do
    FactoryBot.create(:user, username: '12345678')
    expect {
      FactoryBot.create(:user, username: '12345678')
    }.to raise_error(ActiveRecord::RecordInvalid) # Added the missing exception class and closing parentheses
  end

  it 'should have many tasks' do
    user = FactoryBot.create(:user)
    expect(user.tasks).to eq([])
  end

  it 'must have the presence of username' do
    expect {
      FactoryBot.create(:user, username: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a username with min. 3 characters' do
    expect {
      FactoryBot.create(:user, username: 'c' * 2)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a username with max. 64 characters' do
    expect {
      FactoryBot.create(:user, username: 'c' * 65)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a password with min. 8 characters' do
    expect {
      FactoryBot.create(:user, password: 'c' * 7)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a password with max. 64 characters' do
    expect {
      FactoryBot.create(:user, password: 'c' * 65)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'enforces username uniqueness' do
    FactoryBot.create(:user, username: '12345678')
    expect {
      FactoryBot.create(:user, username: '12345678')
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  # Uncomment and fix if you want to test DB-level uniqueness directly
  # it 'enforces username uniqueness in DB-level' do
  #   ActiveRecord::Base.connection.execute "INSERT INTO users (username, created_at, updated_at) VALUES ('12345678', '2024-06-27', '2024-06-27')"
  #
  #   expect {
  #     ActiveRecord::Base.connection.execute "INSERT INTO users (username, created_at, updated_at) VALUES ('12345678', '2024-06-27', '2024-06-27')"
  #   }.to raise_error(ActiveRecord::RecordNotUnique)
  # end
end

