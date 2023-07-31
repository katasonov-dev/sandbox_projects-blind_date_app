require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject(:restaurant) { FactoryBot.build(:restaurant) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:groups).dependent(:nullify) }
  end
end
