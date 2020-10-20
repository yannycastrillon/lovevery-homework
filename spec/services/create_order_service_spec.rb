# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateOrderService, type: :service do
  let(:product) { create(:product) }
  let(:child) { create(:child) }
  let(:order_attrs) do
    {
      product_id: product.id,
      shipping_name: 'Shipping Name',
      address: '125 Westeros RD',
      zipcode: '90028',
      paid: false
    }
  end
  let(:card_attrs) do
    {
      credit_card_number: '4444 4444 4444 4444' ,
      expiration_month: '09',
      expiration_year: '2023'
    }
  end

  subject { described_class.call(order_attrs, child, card_attrs) }

  describe '#call' do
    context 'when NOT created successfully' do
      let(:order_attrs) do
        {
          shipping_name: nil,
          address: '125 Westeros RD',
          zipcode: '90028',
          child: child,
          user_facing_id: 'yen4n5k8',
          paid: :false
        }
      end
      before do
        allow_any_instance_of(described_class).to receive(:generate_uuid).and_return('yen4n5k8')
        allow(Order).to receive(:create).with(order_attrs)
      end
      it 'must return Failure instance' do
        expect(subject.status).to eq(:failure)
        expect(subject).to be_instance_of(Failure)
      end
    end

    context 'when an Order gets created successfully' do
      context 'when purchase process is done successfully' do
        it 'must return a Success with the order object' do
          expect(subject.status).to eq(:success)
          expect(subject).to be_instance_of(Success)
          expect(subject.object).to be_instance_of(Order)
        end
      end

      context 'when purchase process is NOT done successfully' do
        let(:card_attrs) do
          {
            credit_card_number: '4242424242424242' ,
            expiration_month: '09',
            expiration_year: '2023'
          }
        end
        it 'must return Failure instance' do
          expect(subject.status).to eq(:failure)
          expect(subject).to be_instance_of(Failure)
        end
      end
    end
  end
end
