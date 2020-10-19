require 'rails_helper'

RSpec.describe Gift, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:child) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:gifter) }
    it { is_expected.to have_many(:order_gifts) }
    it { is_expected.to have_many(:orders).through(:order_gifts) }
  end
end
