require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should belong_to(:department) }
    it { should belong_to(:group).optional }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(admin: 0, employee: 1) }
  end

  describe '#eligible_to_lead?' do
    let(:user) { create(:user) }

    context 'when group_leader_at is nil' do
      it 'returns true' do
        expect(user.eligible_to_lead?).to be true
      end
    end

    context 'when group_leader_at is older than 2 weeks' do
      it 'returns true' do
        user.update(group_leader_at: 3.weeks.ago)
        expect(user.eligible_to_lead?).to be true
      end
    end

    context 'when group_leader_at is within 2 weeks' do
      it 'returns false' do
        user.update(group_leader_at: 1.week.ago)
        expect(user.eligible_to_lead?).to be false
      end
    end
  end
end
