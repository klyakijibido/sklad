class Plant < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
