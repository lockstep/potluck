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
    expect(page).to have_content "Signed in successfully."
  end

  scenario "failed to sign in" do
    visit "/"
    click_link "Sign In"
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: 111111
    click_button "Log in"
    expect(page).to have_content "Invalid"
  end

  scenario "non admin user try to access admin page" do
    visit "/"
    click_link "Sign In"
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "Log in"
    visit "/admin"
    expect(page).to have_content "Not authorized"
  end
end
