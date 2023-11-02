class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :country
  belongs_to :plant
  has_many :operations

  validates :price, presence: true
  validates :price_buy, presence: true
  validates :code, presence: true
end
