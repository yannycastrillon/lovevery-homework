# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchGifterService, type: :service do
  let(:first_name) { 'Tyrion' }
  let(:last_name) { 'Lannister' }
  let(:email) { 'tyrion.lannister@kingslanding.com' }

  describe '#call' do
    subject { described_class.call(first_name, last_name, email) }

    context 'when gifter record exists on database' do
      let!(:gifter) { create(:gifter, first_name: first_name, last_name: last_name, email: email) }

      it 'must return the founded record' do
        expect { subject }.not_to change { Gifter.count }
      end
    end

    context 'when gifter record does not exists on dabase' do
      let(:email) { 'tlannister@kingslanding.com' }

      it 'must create and save a new record' do
        expect { subject }.to change { Gifter.count }.by(1)
      end
    end
    context 'when record does not exists and creation no possible' do
      let(:email) { nil }

      it 'must raise an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

