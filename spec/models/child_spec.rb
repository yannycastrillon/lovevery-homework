require 'rails_helper'

RSpec.describe Child, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:gifts) }
    it { is_expected.to have_many(:gifters).through(:gifts) }
  end
end
