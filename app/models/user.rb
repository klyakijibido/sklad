class User < ApplicationRecord
  has_many :operations

  validates :name, presence: true, uniqueness: true
end
