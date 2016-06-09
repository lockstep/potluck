describe PotlucksController, type: :controller do
  describe '#index' do
    before do
      @potluck = create(:potluck)
    end
    it 'renders the potlucks index' do
      get :index
      expect(response).to render_template('potlucks/index')
      expect(assigns(:potlucks)).to eq([@potluck])
    end
  end

  describe '#show' do
    before do
      @potluck = create(:potluck)
    end
    it 'renders the show template' do
      get :show, id: @potluck.id
      expect(response).to render_template('potlucks/show')
      expect(assigns(:potluck)).to eq @potluck
    end
  end
end
