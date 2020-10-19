class Order < ApplicationRecord
  belongs_to :product
  belongs_to :child
  has_one :order_gift
  has_one :gift, through: :order_gift

  validates :shipping_name, presence: true

  def to_param
    user_facing_id
  end
end
