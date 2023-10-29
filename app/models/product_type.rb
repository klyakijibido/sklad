class ProductType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
