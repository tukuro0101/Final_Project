class RemoveRateFromTaxTypes < ActiveRecord::Migration[6.1]
  def change
    remove_column :tax_types, :rate, :decimal
  end
end
