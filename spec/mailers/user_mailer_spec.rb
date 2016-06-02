describe "UserMailer"do
  include_context 'before_after_mailer'
  let(:user)  { create(:user) }

  describe '.welcome_new_user' do
    before { UserMailer.welcome_new_user(user).deliver_now }
    it_behaves_like "sending_email" do
      let(:sender)     { ['hello@potluck.com'] }
      let(:recipients) { [ user.email] }
      let(:subject)    { 'Welcome to Potluck' }
    end
  end
end
