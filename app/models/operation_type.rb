class OperationType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :multiplier_cash, presence: true
  validates :multiplier_quantity, presence: true
end
