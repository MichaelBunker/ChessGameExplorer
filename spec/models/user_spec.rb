require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end
  it { should validate_presence_of :email }
  it 'returns correct email' do
   expect(@user.email).to eq 'bunker@gmail.com'
  end
  it 'returns correct password' do
    expect(@user.password).to eq 'password123'
  end
end
