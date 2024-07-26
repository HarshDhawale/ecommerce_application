class Product < ApplicationRecord
  has_many :orders
  has_many :customers, through: :orders
  has_many :order_items
  validates :name, :price, :category, presence:true
end
