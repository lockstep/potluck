describe Potluck, type: :model do
  describe '#token' do
    before do
      @potluck = create(:potluck)
    end
    it 'returns a unique 24 char potluck token' do
      expect(@potluck.token).to be_a String
      expect(@potluck.token.length).to eq 24
    end
  end
end
