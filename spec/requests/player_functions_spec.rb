require 'rails_helper'

RSpec.describe "PlayerFunctions", type: :request do

  before do
    User.create(email: "bunker@gmail.com", password: "password123", password_confirmation: "password123")
    visit root_path
    click_link "Login"
    fill_in "Email", with: "bunker@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
  end

  describe 'the add a player process' do
    it "adds a player" do
      click_link "Add a new Player"
      fill_in "Name", with: "Jack"
      fill_in "Rating", with: "2000"
      click_on "Add"
      expect(page).to have_content "Page for Jack"
      expect(page).to have_content "rating: 2000"
    end
  end

  describe 'the edit player process' do
    it 'Edits a player' do
      click_link "Add a new Player"
      fill_in "Name", with: "Jack"
      fill_in "Rating", with: "2000"
      click_on "Add"
      click_on "Edit this player"
      fill_in "Name", with: "Bob"
      fill_in "Rating", with: "1000"
      click_on "Add"
      expect(page).to have_content "Page for Bob"
      expect(page).to have_content "rating: 1000"
    end
  end

  describe 'the destroy a player process' do
    it "destroy a player" do
      player = Player.create(name: "Jack", rating: 2000)
      visit root_path
      click_link "Jack"
      click_link "Delete this player"
      expect(page).to have_no_content "Hello World!"
    end
  end

end
