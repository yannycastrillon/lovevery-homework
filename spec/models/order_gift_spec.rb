require 'rails_helper'

RSpec.describe OrderGift, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:gift) }
  end
end
