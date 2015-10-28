require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :rating }
  it { should have_many(:games).through(:matches) }
end