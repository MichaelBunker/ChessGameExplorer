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
  end
end
