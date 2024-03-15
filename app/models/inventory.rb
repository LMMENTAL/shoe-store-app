class Inventory < ApplicationRecord
  self.table_name = "products_stores"

  belongs_to :store
  belongs_to :product
  has_many :alerts
end
