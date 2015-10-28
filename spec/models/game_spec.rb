require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should validate_presence_of :notation }
end
