class DropProvincesTable < ActiveRecord::Migration[6.1]
  def up
    #drop_table :provinces
  end

  def down
    create_table :provinces do |t|
      t.string :name
      t.timestamps
    end
  end
end
