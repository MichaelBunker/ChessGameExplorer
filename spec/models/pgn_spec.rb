require 'rails_helper'

RSpec.describe Pgn, type: :model do
  it { should validate_presence_of :pgn }
end
