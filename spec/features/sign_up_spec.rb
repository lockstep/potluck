require "rails_helper"

feature "user sign up" do

  scenario "visit site to sign up" do
    visit "/"
    click_link "Sign Up"
    fill_in "user[email]", with: "user@mail.com"
    fill_in "user[password]", with: 111111
    fill_in "user[password_confirmation]", with: 111111
    click_button "Sign up"
    expect(page).to have_content "Welcome! "
  end

  scenario "failed to sign up" do
    user = create(:user)
    visit "/"
    click_link "Sign Up"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: 111111
    fill_in "user[password_confirmation]", with: 111111
    click_button "Sign up"
    expect(page).to have_content "Email has already been taken"
  end
end
