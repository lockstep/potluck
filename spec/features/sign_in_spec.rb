require "rails_helper"

feature "user sign in" do
  before do
    @user = create(:user)
  end
  scenario "visit site to sign in" do
    visit "/"
    click_link "Sign In"
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "Log in"
  end
end
