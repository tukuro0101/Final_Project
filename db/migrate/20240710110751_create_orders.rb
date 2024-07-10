class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.decimal :subtotal
      t.decimal :gst
      t.decimal :hst
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
