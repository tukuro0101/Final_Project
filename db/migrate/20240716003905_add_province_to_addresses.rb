class AddProvinceToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :province, foreign_key: true
  end
end
