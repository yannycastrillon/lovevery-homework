class Gift < ApplicationRecord
  belongs_to :child
  belongs_to :product
  belongs_to :gifter
  has_one :order_gift
  has_one :order, through: :order_gift
end
