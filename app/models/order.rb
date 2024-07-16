class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :address, as: :addressable

  def add_cart_items(cart)
    cart.cart_items.each do |item|
      order_items.build(product: item.product, quantity: item.quantity, price: item.product.price)
    end
  end

  def calculate_totals
    self.subtotal = order_items.sum { |item| item.price * item.quantity }
    self.gst = subtotal * 0.05
    self.hst = subtotal * 0.13
    self.total_price = subtotal + gst + hst
  end
end
