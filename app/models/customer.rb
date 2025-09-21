class Customer < ApplicationRecord
    has_many :sales, dependent: :destroy
    validates :full_name, :email, :birthdate, presence: true
    validates :email, uniqueness: true
end
