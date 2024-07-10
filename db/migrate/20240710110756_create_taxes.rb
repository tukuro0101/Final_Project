class CreateTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :taxes do |t|
      t.string :province
      t.decimal :gst_rate
      t.decimal :hst_rate

      t.timestamps
    end
  end
end
