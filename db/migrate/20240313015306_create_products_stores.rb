class CreateProductsStores < ActiveRecord::Migration[7.1]
  def change
    create_table :products_stores, id: :uuid do |t|
      t.references :product, null: false, type: :uuid
      t.references :store, null: false, type: :uuid
      t.integer :count

      t.index :count
      t.timestamps
    end

    add_index(:products_stores, [:product_id, :store_id], unique: true)
  end
end