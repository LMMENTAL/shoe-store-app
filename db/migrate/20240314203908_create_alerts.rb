class CreateAlerts < ActiveRecord::Migration[7.1]
  def change
    create_table :alerts do |t|
      t.string :message
      t.integer :level
      t.string :inventory_id

      t.timestamps
    end
  end
end
