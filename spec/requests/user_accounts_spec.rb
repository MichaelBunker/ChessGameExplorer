require 'rails_helper'

RSpec.describe "UserAccounts", type: :request do
  describe "the sign up process" do
    it "signs a user up" do
      visit root_path
      click_link "Sign Up"
      fill_in "Email", with: "bunker@gmail.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
      click_on "Sign up"
      expect(page).to have_content "Hello World!"
    end

    it "logs a user in" do
      User.create(email: "bunker@gmail.com", password: "password123", password_confirmation: "password123")
      visit root_path
      click_link "Login"
      fill_in "Email", with: "bunker@gmail.com"
      fill_in "Password", with: "password123"
      click_on "Log in"
      expect(page).to have_content "Hello World!"
    end

    it "logs a user out" do
      User.create(email: "bunker@gmail.com", password: "password123", password_confirmation: "password123")
      visit root_path
      click_link "Login"
      fill_in "Email", with: "bunker@gmail.com"
      fill_in "Password", with: "password123"
      click_on "Log in"
      click_on "Logout"
      expect(page).to have_content "Log in"
    end

  end
end
