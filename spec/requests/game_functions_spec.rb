require 'rails_helper'

RSpec.describe "PlayerFunctions", type: :request do
  describe 'the add a player process' do
    it "adds a player" do
      User.create(email: "bunker@gmail.com", password: "password123", password_confirmation: "password123")
      visit root_path
      click_link "Login"
      fill_in "Email", with: "bunker@gmail.com"
      fill_in "Password", with: "password123"
      click_on "Log in"
      click_link "Add a new game"
      fill_in "Notation", with: "1.e4e5 2.nf3nc6"
      click_on "Add"
      expect(page).to have_content "1.e4e5 2.nf3nc6"
    end
  end
end
