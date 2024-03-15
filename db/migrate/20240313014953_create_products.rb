class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.integer :type, null: false, default: 0
      t.integer :inventory_threshold, default: 10
      t.decimal :cost

      t.index :type
      t.timestamps
    end
  end
end
