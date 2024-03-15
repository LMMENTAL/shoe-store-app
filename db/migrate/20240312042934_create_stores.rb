class CreateStores < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'

    create_table :stores, id: :uuid do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.index :latitude
      t.index :longitude
      t.timestamps
    end
  end
end
