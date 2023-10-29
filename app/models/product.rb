class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :country
  belongs_to :plant

  validates :price, presence: true
  validates :price_buy, presence: true
end
