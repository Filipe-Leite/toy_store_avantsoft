class Sale < ApplicationRecord
  belongs_to :customer
  validates :date, :value, presence: true
end
