require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { should have_many(:users) }
    it { should belong_to(:restaurant).optional }
  end

  describe 'scopes' do
    describe '.for_week' do
      let!(:group1) { create(:group, week_number: 1) }
      let!(:group2) { create(:group, week_number: 2) }

      it 'returns groups with the specified week_number' do
        expect(Group.for_week(1)).to eq([group1])
        expect(Group.for_week(2)).to eq([group2])
      end
    end
  end

  describe '#leader' do
    let(:leader_user) { create(:user) }
    let(:group) { create(:group, leader_id: leader_user.id) }

    it 'returns the leader user' do
      expect(group.leader_id).to eq(leader_user.id)
    end
  end
end
