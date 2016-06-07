feature "user sign in" do
  before do
    @user = create(:user)
  end
  context "visit site to sign in" do
    it "sign in successfully" do
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "Log in"
      expect(page).to have_content "Signed in successfully."
    end

    it "failed to sign in" do
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: 111111
      click_button "Log in"
      expect(page).to have_content "Invalid"
    end

    it "non admin user try to access admin page" do
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "Log in"
      visit "/admin"
      expect(page).to have_content "Not authorized"
    end
  end
end
