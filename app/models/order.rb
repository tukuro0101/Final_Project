class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :address

  before_save :set_subtotal
  before_save :calculate_taxes

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

  def set_subtotal
    self[:subtotal] = subtotal
  end

  def calculate_taxes
    province = address.province
    self[:gst] = subtotal * (province.gst_rate / 100.0)
    self[:pst] = subtotal * (province.pst_rate / 100.0)
    self[:hst] = subtotal * (province.hst_rate / 100.0)
    self[:total_price] = subtotal + gst + pst + hst
  end
end
