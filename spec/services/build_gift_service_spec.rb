# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuildGiftService, type: :service do
  let(:message) { 'Enjoy this new toy' }
  let(:child) { create(:child) }
  let(:gifter) { build_stubbed(:gifter) }
  let(:product) { create(:product, :between_13_and_17) }
  let(:gift) { build_stubbed(:gift, product: product, message: message) }
  let(:credit_card_attrs) do
    {
      credit_card_number: '4444 4444 4444 4444' ,
      expiration_month: '09',
      expiration_year: '2023'
    }
  end

  subject { described_class.call(child.attributes, gifter.attributes, gift.attributes, credit_card_attrs) }

  describe '#call' do
    context 'when child and gifter are found' do
      let(:order) { build(:order) }
      let(:order_info) do
        {
          product_id: product.id,
          shipping_name: 'Arya Stark',
          address: '123 Nithwatch RD',
          zipcode: '90028',
          paid: false
        }
      end
      before do
        allow(SearchChildService).to(
          receive(:call).with(child.full_name, child.birthdate, child.parent_name)
                        .and_return(Success.new(object: child))
        )
        allow(SearchGifterService).to(
          receive(:call).with(gifter.first_name, gifter.last_name, gifter.email)
                        .and_return(gifter)
        )
        allow(CreateOrderService).to(
          receive(:call).and_return(Success.new(object: order))
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
