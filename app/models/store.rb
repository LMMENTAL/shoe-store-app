class Store < ApplicationRecord
	has_and_belongs_to_many :products
  has_many :inventories

  include GeoCoordination

  scope :with_sufficient_inventory, ->(product_id) { joins(:products).where(['products.id = ? AND products_stores.count > products.inventory_threshold', product_id]) }
  scope :nearby_stores, ->(center_latitude, center_longitude, radius, id) { where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", center_latitude - radius, center_latitude + radius, center_longitude - radius, center_longitude + radius).where.not(id: id) }
  
  STORE_RADII = [10**-1, 1, 10, 10**2, 10**3, 10**4, 10**5]

  # Filtering for stores with sufficient inventory.
  # Incrementally expanding radius in a log scale until values are returned to avoid doing extra in memory calculation on all stores
  # Could benchmark other solutions or analyze data to better choose step sizes if given more time.
  def closest_cluster(product_id)
    stores = Store.with_sufficient_inventory(product_id)
    STORE_RADII.each do |radius|
      nearby_stores = stores.nearby_stores(latitude, longitude, radius, id)
      return nearby_stores.select(:latitude, :longitude, :id) if nearby_stores.any?
    end
    return []
  end

  def closest_store(product_id)
    store_id = nil
    # Farthest possible distance in m between two points on Earth
    smallest_distance = 20_037_000

    closest_cluster(product_id).each do |store|
      distance = calculate_distance(store.latitude, store.longitude)
      next unless distance < smallest_distance
      store_id = store.id
      smallest_distance = distance
    end

    return Store.find_by(id: store_id), smallest_distance
  end

  def calculate_distance(latitude_2, longitude_2)
    geo_coordinate_1 = [latitude, longitude]
    geo_coordinate_2 = [latitude_2, longitude_2]

    distance_between_coordinates(geo_coordinate_1, geo_coordinate_2)
  end

end