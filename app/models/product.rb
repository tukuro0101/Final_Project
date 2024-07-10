class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  has_one_attached :image
end
