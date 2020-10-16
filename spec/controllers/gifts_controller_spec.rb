# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GiftsController, type: :controller do
  let(:gifter) { create(:gifter) }
  let(:product) { create(:product, :between_13_and_17) }

  let(:child1) { create(:son) }

  describe 'GET #new' do
    it 'must return success' do
      get :new, params: { gift: { product_id: product.id } }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let!(:gift) { create(:gift, product: product, gifter: gifter, child: child1) }

    context 'when gift record is found' do
      it 'must return success' do
        get :show, params: { id: gift.id }
  
        expect(response).to have_http_status(:success)
      end
    end
   
    context 'when gift record is not found' do
      xit 'returns http not_found' do
        get :show, params: { id: 9999 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context "when child's Name or Birthday or child's Parent Name does not match" do
      let(:params) { { child_name: 'Tyrion', birthdate: Date.new(1600,9,23), parent_name: 'Jaime' } }

      before { child1 }
      it 'must return error' do
        post :create, params: params

        expect(response).to have_http_status(:bad_request)
      end
    end
    context "when child's Name, Birthday, and child's Parent Name does match" do
      let(:params) { { child_name: child1.full_name, birthdate: child1.birthdate, parent_name: child1.parent_name }}

      it 'must return success and create a new record on gift database' do
        expect {
          post :create, params: params

        }.to change(Gift, :count).by(1)

        expect(response).to have_http_status(:success)
      end
    end
  end
end

