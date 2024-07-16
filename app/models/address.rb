class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders

  validates :street, :city, :province_id, :postal_code, presence: true
end
