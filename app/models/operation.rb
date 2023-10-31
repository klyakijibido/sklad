class Operation < ApplicationRecord
  belongs_to :product
  belongs_to :operation_type
  belongs_to :user
  belongs_to :shop

  validates :created, presence: true
  validates :quantity, presence: true
  validates :sale_price, presence: true
  validates :discount_percent, presence: true
end
