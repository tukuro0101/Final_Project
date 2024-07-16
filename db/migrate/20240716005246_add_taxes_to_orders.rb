class AddTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pst, :decimal
    add_column :orders, :qst, :decimal
  end
end
