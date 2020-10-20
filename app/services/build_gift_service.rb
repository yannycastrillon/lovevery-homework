# frozen_string_literal: true

class BuildGiftService < ApplicationService
  def initialize(child_attrs, gifter_attrs, gift_attrs, credit_card_attrs)
    @gift = Gift.new(gift_attrs)
    @new_child = Child.new(child_attrs)
    @gifter = Gifter.new(gifter_attrs)
    @card_info = credit_card_attrs
  end

  def call
    result = SearchChildService.call(full_name, birthdate, parent_name)
    return result if result.is_a?(Failure)

    gift.child = result.object
    gift.gifter = SearchGifterService.call(first_name, last_name, email)

    order_result = CreateOrderService.call(order_info, gift.child, card_info)
    return order_result if order_result.is_a?(Failure)

    gift.order = order_result.object
    Success.new(object: gift)
  end

  private

  attr_accessor :gift, :gifter, :new_child, :card_info

  delegate :first_name, :last_name, :email, to: :gifter
  delegate :full_name, :birthdate, :parent_name, to: :new_child

  def order_info
    last_order = gift.child.orders.last
    {
      product_id: gift.product_id,
      shipping_name: last_order&.shipping_name,
      address: last_order&.address,
      zipcode: last_order&.zipcode,
      paid: false
    }
  end
end