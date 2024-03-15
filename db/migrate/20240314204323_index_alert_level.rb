class IndexAlertLevel < ActiveRecord::Migration[7.1]
  def change
    add_index(:alerts, :level)
  end
end
