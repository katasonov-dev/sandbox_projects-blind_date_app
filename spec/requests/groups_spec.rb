require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe 'GET #index' do
    let!(:group) { create(:group, week_number: Date.today.cweek) }

    before { get groups_path }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns @groups' do
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe 'GET #show' do
    let(:group) { create(:group, :with_employees) }

    before { get group_path(group) }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'assigns @employees' do
      expect(assigns(:employees)).to match_array(group.users)
    end
  end
end
