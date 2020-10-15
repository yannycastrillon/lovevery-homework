class Gift < ApplicationRecord
  belongs_to :child
  belongs_to :product
  belongs_to :gifter
end
