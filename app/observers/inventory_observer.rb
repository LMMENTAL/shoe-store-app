# Observes Inventory to check if the value goes below or above a certain threshold which is dynamic based on the product threshold value.
class InventoryObserver < ActiveRecord::Observer

  def after_save(inventory)
    return unless inventory.count < inventory.product.inventory_threshold

    store = inventory.store
    product = inventory.product
    nearest_store, distance_away = store.closest_store(inventory.product_id)
    message = "\u26A0 #{store.name} is running low on #{product.name} (#{inventory.count}). The closest store with sufficient inventory is #{nearest_store.name} which is #{(distance_away/1000).round}km away. 'Websocket Payload ID: #{inventory.websocket_payload_id}'".encode("utf-8")
    level = Math.log(distance_away/1000).round
    puts "message: #{message}, level: #{level}, #{(distance_away/1000).round}km"
    Alert.create(message:, level:, inventory_id: inventory.id)
  end

end
