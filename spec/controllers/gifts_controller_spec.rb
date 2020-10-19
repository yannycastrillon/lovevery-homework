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
      it 'returns http not_found' do
        get :show, params: { id: 9999 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context "when child's parameters (full_name, birthdate or parent_name) does not match any children records" do
      let(:params) do 
        {
          gift: {
            product_id: product.id,
            child: {
              full_name: 'Tyrion Lannister', 
              birthdate: Date.new(1600,9,23),
              parent_name: 'Jaime Lannister'
            },
            gifter: {
              first_name: gifter.first_name,
              last_name: gifter.last_name,
              email: gifter.email
            }
          }
        }
      end

      before { child1 }

      it 'must return error' do
        post :create, params: params

        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors']).to eq(['Child was not found']) 
      end
    end

    context "when child's Name, Birthdate, and child's Parent Name does match" do
      let(:params) do 
        {
          gift: {
            product_id: product.id,
            child: {
              full_name: child1.full_name, 
              birthdate: child1.birthdate,
              parent_name: child1.parent_name,
            },
            gifter: {
              first_name: gifter.first_name,
              last_name: gifter.last_name,
              email: gifter.email
            }
          }
        }
      end

      it 'must return success and create a new gift record' do
        post :create, params: params 

        gift = Gift.includes(:child, :gifter).last

        expect(gift.child.full_name).to eq(child1.full_name)
        expect(gift.child.birthdate).to eq(child1.birthdate)
        expect(gift.child.parent_name).to eq(child1.parent_name)

        expect(gift.gifter.first_name).to eq(gifter.first_name)
        expect(gift.gifter.last_name).to eq(gifter.last_name)
        expect(gift.gifter.email).to eq(gifter.email)
      end
    end
  end
end

