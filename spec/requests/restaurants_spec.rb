require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:group) { create(:group, leader_id: user.id) }

  describe 'POST /restaurants/:id/select' do
    before do
      Warden.test_mode!
      login_as(user, scope: :user)
    end

    after do
      Warden.test_reset!
    end

    context 'when the user is the leader of the group' do
      it 'selects the restaurant for the group' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(group.reload.restaurant).to eq(restaurant)
      end

      it 'redirects to the group page' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(response).to redirect_to(group_path(group))
      end

      it 'sets a success flash message' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(flash[:notice]).to eq('Restaurant selected successfully.')
      end
    end

    context 'when the user is not the leader of the group' do
      let(:group) { create(:group, leader_id: -1) }

      it 'does not select the restaurant for the group' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(group.reload.restaurant).to be_nil
      end

      it 'redirects to the group page' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(response).to redirect_to(group_path(group))
      end

      it 'sets an alert flash message' do
        post select_restaurant_path(restaurant, id: group.id, restaurant_id: restaurant.id)
        expect(flash[:alert]).to eq('You are not the leader of this group.')
      end
    end
  end
end
