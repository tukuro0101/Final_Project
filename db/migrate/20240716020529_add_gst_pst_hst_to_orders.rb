class AddGstPstHstToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :gst, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :orders, :pst, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :orders, :hst, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :orders, :qst, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
