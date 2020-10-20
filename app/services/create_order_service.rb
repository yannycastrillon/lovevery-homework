# frozen_string_literal: true

class CreateOrderService < ApplicationService
  def initialize(order_attrs, child, credit_card_attrs)
    @child = child
    @order_attrs = order_attrs
    @card_attrs = credit_card_attrs
  end

  def call
    order = Order.create(order_attrs.merge(child: child, user_facing_id: generate_uuid))
    return Failure.new(error: order_error_message(order)) unless order&.valid?

    purchase = Purchaser.new.purchase(order, card_attrs)
    return Failure.new(error: 'InvalidCreditCard') unless purchase

    Success.new(object: order)
  end

  private

  attr_accessor :order_attrs, :child, :card_attrs

  def generate_uuid
    SecureRandom.uuid[0..7]
  end

  def order_error_message(order)
    return Errors::OrderNotCreated.new 'Order not created' unless order

    Errors::OrderFieldError.new(order.errors.messages)
  end
end