# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchChildService, type: :service do
  let(:birthdate) { Date.new(2020, 06, 06) }
  let(:child_name) { 'Aegon Targaryen' }
  let(:parent_name) { 'Rhaegar Targaryen' }

  describe '#call' do
    subject { described_class.call(child_name, birthdate, parent_name) }

    context 'when child is found in our system' do
      let!(:true_heir) do
        create(:son, full_name: 'Aegon Targaryen', parent_name: 'Rhaegar Targaryen',
               birthdate: Date.new(2020, 06, 06))
      end

      it 'must return child record' do
        expect(subject).to be_instance_of(Success)
        expect(subject.object.id).to eq(true_heir.id)
        expect(subject.object.full_name).to eq('Aegon Targaryen')
        expect(subject.object.parent_name).to eq('Rhaegar Targaryen')
        expect(subject.object.birthdate).to eq(Date.new(2020, 06, 06))
      end
    end

    context 'when child is not found in our system' do
      let!(:not_heir) do
        create(:son, full_name: 'Sansa Stark', parent_name: 'Ned Stark',
               birthdate: Date.new(2020, 06, 06))
      end
      it 'must raise ChildNotFound error' do
        expect(subject).to be_instance_of(Failure)
        expect(subject.error).to be_instance_of(Errors::ChildNotFound)
        expect(subject.error.message).to eq('Child was not found')
      end
    end
  end
end
