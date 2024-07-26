class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  has_many :order_items
end
