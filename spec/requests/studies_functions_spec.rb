require 'rails_helper'

RSpec.describe "studyFunctions", type: :request do

  before do
    user = create(:user)
    player = create(:player)
    visit root_path
    click_link "Login"
    fill_in "Email", with: "bunker@gmail.com"
    fill_in "Password", with: "password123"
    click_on "Log in"
  end
  it "searches a topic of study" do
    click_on "Study"
    fill_in "study_name", with: "Chess"
    click_on "Search"
    sleep(3)
    expect(page).to have_content "Chess"
  end
end
