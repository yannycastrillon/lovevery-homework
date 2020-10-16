class Child < ApplicationRecord
  has_many :orders
  has_many :gifts
  has_many :gifters, through: :gifts
end
