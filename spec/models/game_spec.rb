require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should validate_presence_of :notation }
  it { should have_and_belong_to_many(:players) }
end
