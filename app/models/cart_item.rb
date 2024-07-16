class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    return 0 unless product && product.price && quantity
    product.price * quantity
  end
end
