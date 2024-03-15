require 'faye/websocket'
require 'eventmachine'
require 'json'

class InventoryDataParser
  include Singleton

  def initialize
    EM.run {
      ws = Faye::WebSocket::Client.new('ws://localhost:8080/')

      ws.on :message do |event|
        update_inventories(JSON.parse(event.data))
      end
    }
  end

  # Could move to a background job to process incoming updates
  def update_inventories(payload)
    shoe = Shoe.find_by(name: payload["model"])
    store = Store.find_by(name: payload["store"])
    Inventory.find_or_create_by(store_id: store.id, product_id: shoe.id).update!(count: payload["inventory"], websocket_payload_id: payload["id"])
  rescue => error
    puts "Error updating inventory with payload: #{payload}"
  end

end