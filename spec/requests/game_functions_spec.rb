require 'rails_helper'

RSpec.describe "PlayerFunctions", type: :request do
  before do
    User.create(email: "bunker@gmail.com", password: "password123", password_confirmation: "password123")
    # page.set_rack_session('warden.user.user.key' => User.serialize_into_session(user).unshift("User"))
    visit root_path
    click_link "Login"
    fill_in "Email", with: "bunker@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
  end

  describe 'the add a player process' do
    it "adds a player" do

      click_link "Add a new game"
      fill_in "Notation", with: "1.e4e5 2.nf3nc6"
      click_on "Add"
      expect(page).to have_content "1.e4e5 2.nf3nc6"
    end
  end

  describe 'the edit game process' do
    it 'Edits a game' do
      click_link "Add a new game"
      fill_in "Notation", with: "1.e4e5 2.nf3nc6"
      click_on "Add"
      click_on "Edit this game"
      fill_in "Notation", with: "1.e4e5"
      click_on "Add"
      expect(page).to have_content "1.e4e5"
    end
  end

  # describe 'the destroy a question process' do
  #   it "destroy a question" do
  #     player = Player.create(name: "Jack", rating: 2000)
  #     visit root_path
  #     click_link "Delete this game"
  #     expect(page).to have_no_content "boo"
  #   end
  # end

end
