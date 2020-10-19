require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:order_gift) }
    it { is_expected.to have_one(:gift).through(:order_gift) }
  end
  
  describe "#validations" do
    it "requires shipping_name" do
      order = Order.new(
        product: Product.new,
        shipping_name: nil,
        address: "123 Some Road",
        zipcode: "90210",
        user_facing_id: "890890908980980"
      )

      expect(order.valid?).to eq(false)
      expect(order.errors[:shipping_name].size).to eq(1)
    end
  end
end
