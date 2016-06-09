feature "Potlucks" do
  before do
    @potluck = create(:potluck)
  end
  it 'can navigate to the potluck from homepage' do
    visit root_path
    click_link 'Potlucks'
    expect(page).to have_content 'Available Potlucks'
    first('.potlucks > li > a').click
    expect(page).to have_content 'This potluck is scheduled to run'
  end
end
