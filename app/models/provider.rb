class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
