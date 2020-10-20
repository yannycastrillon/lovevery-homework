class Order < ApplicationRecord
  belongs_to :product
  belongs_to :child
  has_many :order_gifts
  has_many :gifts, through: :order_gifts

  validates :shipping_name, presence: true

  def to_param
    user_facing_id
  end
end
