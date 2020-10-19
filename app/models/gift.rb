class Gift < ApplicationRecord
  belongs_to :child
  belongs_to :product
  belongs_to :gifter
  has_many :order_gifts
  has_many :orders, through: :order_gifts 
end
