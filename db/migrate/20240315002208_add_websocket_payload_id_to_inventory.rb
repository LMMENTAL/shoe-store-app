class AddWebsocketPayloadIdToInventory < ActiveRecord::Migration[7.1]
  def change
    add_column :products_stores, :websocket_payload_id, :string
  end
end
