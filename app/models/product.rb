class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  has_one_attached :image
  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if image.attached?
  end
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  paginates_per 20
end
