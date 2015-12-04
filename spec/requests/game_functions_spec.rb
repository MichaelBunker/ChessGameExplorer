require 'rails_helper'

RSpec.describe "GameFunctions", type: :request do
  let(:player){ create :player }
  let(:game){ create :game }
  pry
  before do
    user = create(:user)
    # game = create(:game)
    visit root_path
    click_link "Login"
    fill_in "Email", with: "bunker@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
  end
  it "adds a game" do
    click_link "Add a new game"
    fill_in "game_notation_form", with: :game
    click_on "Add"
    expect(page).to have_content "1.ne4 e5 2. Nf3 Nc6"
  end
  # it 'Edits a game' do
  #   click_link "Add a new game"
  #   # same thing as player function testing.
  #   fill_in "game_notation_form", with: game
  #   click_on "Add"
  #   click_on "Edit this game"
  #   fill_in "game_notation_form", with: "1. e4 e5"
  #   click_on "Add"
  #   expect(page).to have_content "1. e4 e5"
  # end
  # it "destroy a game" do
  #   visit root_path
  #   click_link "Add a new game"
  #   fill_in "game_notation_form", with: game
  #   click_on "Add"
  #   click_link "Delete this game"
  #   expect(page).to have_content "Game Database"
  # end
end
