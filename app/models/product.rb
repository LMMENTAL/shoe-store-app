class Product < ApplicationRecord
	enum type: [ "Shoe", "Pants", "Tee" ]

  has_and_belongs_to_many :stores
  has_many :inventories
end