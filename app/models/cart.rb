class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id)
    current_item = cart_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id, quantity: 1)
    end
    current_item.save!
    current_item
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end
end
