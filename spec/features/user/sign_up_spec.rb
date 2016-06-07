feature "user sign up" do

  context "visit site to sign up" do
    it "sign up successfully" do
      visit new_user_registration_path
      fill_in "user[email]", with: "user@mail.com"
      fill_in "user[password]", with: 111111
      fill_in "user[password_confirmation]", with: 111111
      click_button "Sign up"
      expect(page).to have_content "Welcome! "
    end

    it "failed to sign up" do
      user = create(:user)
      visit new_user_registration_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: 111111
      fill_in "user[password_confirmation]", with: 111111
      click_button "Sign up"
      expect(page).to have_content "Email has already been taken"
    end
  end
end
