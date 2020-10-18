# frozen_string_literal: true

class BuildGiftService < ApplicationService
  def initialize(child_attributes, gifter_attributes, gift_attributes)
    @gift = Gift.new(gift_attributes)
    @child = Child.new(child_attributes)
    @gifter = Gifter.new(gifter_attributes)
  end

  def call
    result = SearchChildService.call(full_name, birthdate, parent_name)
    return result if result.is_a?(Failure)

    gift.child = result.object
    gift.gifter = SearchGifterService.call(first_name, last_name, email)

    Success.new(object: gift)
  end

  private

  attr_accessor :gift, :gifter, :child

  delegate :first_name, :last_name, :email, to: :gifter
  delegate :full_name, :birthdate, :parent_name, to: :child
end