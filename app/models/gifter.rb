class Gifter < ApplicationRecord
  has_many :gifts
  has_many :children, through: :gifts

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
