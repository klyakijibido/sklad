class Operation < ApplicationRecord
  belongs_to :product
  belongs_to :operation_type
  belongs_to :user
  belongs_to :disco_card
  belongs_to :cash_register
  belongs_to :shop

  validates :date_created, presence: true
  validates :quantity, presence: true
  validates :sale_price, presence: true
  validates :discount_percent, presence: true
end
