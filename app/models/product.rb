class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :country
  belongs_to :plant
  has_many :operations

  validates :price, presence: true
  validates :price_buy, presence: true
  validates :code, presence: true

  scope :my_search_by_query, ->(query) { where("name LIKE :query OR art LIKE :query OR razd LIKE :query OR ean13 LIKE :query", query: "%#{query}%") }
end
