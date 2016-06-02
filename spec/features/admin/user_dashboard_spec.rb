feature 'admin login' do
  before do
    @admin = create(:admin)
    @user = create(:user)
  end
  context "admin visit admin homepage" do
    it "show users list" do
      login
      visit "/admin/users"
      expect(page).to have_content @user.first_name
      expect(page).to have_content @user.organization.name
    end

    it "can edit user's info" do
      login
      visit edit_admin_user_path(@user)
      expect(page).to have_content("Edit #{@user.first_name} #{@user.last_name}")

      fill_in "First name", with: "Firstname"
      click_on "Update User"

      expect(page).to have_content("User was successfully updated.")
      expect(@user.reload.first_name).to eq "Firstname"
    end

    it "can create user" do
      login
      visit new_admin_user_path
      fill_in "First name", with: "Firstname"
      fill_in "Last name", with: "Lastname"
      fill_in "Email", with: "user@mail.com"
      click_on "Create User"

      expect(page).to have_content "User was successfully created."
    end

    it "can access and see user's info page" do
      login
      visit admin_user_path(@user)
      expect(page).to have_content("#{@user.first_name} #{@user.last_name}")
    end

    context 'search' do
      include Warden::Test::Helpers
      before do
        Warden.test_mode!
        login_as(@admin)
      end
      after {Warden.test_reset!}
      it "show the correct result", js: true do
        visit admin_users_path
        expect(page).to have_content @user.email
        expect(page).to have_content @admin.email

        fill_in :search, with: @user.email
        page.execute_script("$('.search').submit()")

        expect(page).to have_content @user.email
        expect(page).to_not have_content @admin.email
      end
    end
  end

  def login
    visit new_user_session_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Log in"
    expect(page).to have_content 'Signed in'
  end
end
