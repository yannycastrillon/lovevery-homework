# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuildGiftService, type: :service do
  let(:message) { 'Enjoy this new toy' }
  let(:child) { build_stubbed(:child) }
  let(:gifter) { build_stubbed(:gifter) }
  let(:product) { build_stubbed(:product, :between_13_and_17) }
  let(:gift) { build_stubbed(:gift, product: product, message: message) }

  subject { described_class.call(child.attributes, gifter.attributes, gift.attributes) }

  describe '#call' do
    context 'when child and gifter are found' do
      before do
        allow(SearchChildService).to(
          receive(:call).with(child.full_name, child.birthdate, child.parent_name)
                        .and_return(Success.new(object: child))
        )
        allow(SearchGifterService).to(
          receive(:call).with(gifter.first_name, gifter.last_name, gifter.email)
                        .and_return(gifter)
        )
      end
      it 'must return Success and gift instance' do
        
        expect(subject.status).to eq(:success)
        expect(subject).to be_instance_of(Success)
        expect(subject.object.present?).to be_truthy
        expect(subject.object).to eql(gift)
      end
    end

    context 'when either child is not found' do
      before do
        allow(SearchChildService).to(
          receive(:call).with(child.full_name, child.birthdate, child.parent_name)
                        .and_return(Failure.new(error: 'The error'))
        )
      end
      it 'must return Failure and an error message' do
        expect(subject.status).to eq(:failure)
        expect(subject).to be_instance_of(Failure)
        expect(subject.error).to eq('The error')
      end
    end
  end
end
