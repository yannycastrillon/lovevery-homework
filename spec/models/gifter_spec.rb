require 'rails_helper'

RSpec.describe Gifter, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:children).through(:gifts) }
    it { is_expected.to have_many(:gifts) }
  end

  describe "#validations" do
    subject { Gifter.new(first_name: 'Jon', last_name: 'Snow', email: 'jon.snow@example.com') }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
