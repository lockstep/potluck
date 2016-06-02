require "rails_helper"

feature 'admin login' do
  before do
    @admin = create(:admin)
    @organization = create(:organization)
    @user = create(:user, organization: @organization )
  end
  context "admin visit admin homepage" do
    it "show users list" do
      login
      visit admin_organizations_path
      expect(page).to have_content @organization.name
    end

    it "can edit organization's info" do
      login
      visit edit_admin_organization_path(@organization)
      expect(page).to have_content("Edit #{@organization.name}")

      fill_in "Name", with: "Aloha"
      click_on "Update Organization"

      expect(page).to have_content("Organization was successfully updated.")
      expect(@organization.reload.name).to eq "Aloha"
    end

    it "can create user" do
      login
      visit new_admin_organization_path
      fill_in "Name", with: "Hello"
      click_on "Create Organization"

      expect(page).to have_content "Organization was successfully created."
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
        @another_organization = create(:organization, name: 'Aloha')
        login_as(@admin)
      end
      after {Warden.test_reset!}
      it "show the correct result", js: true do
        visit admin_organizations_path
        expect(page).to have_content @organization.name
        expect(page).to have_content @another_organization.name

        fill_in :search, with: 'Aloha'
        page.execute_script("$('.search').submit()")

        expect(page).to have_content @another_organization.name
        expect(page).to_not have_content @organization.name
      end
    end
  end

  def login
    visit new_user_session_path
    fill_in "user[email]", with: @admin.email
    fill_in "user[password]", with: @admin.password
    click_button "Log in"
  end
end
