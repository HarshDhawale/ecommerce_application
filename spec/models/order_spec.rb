require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
  it   "belongs to Custonmer" do
    t=Order.reflect_on_association(:customer)
    expect(t.macro).to eq(:belongs_to)
  end
  it   "belongs to Product" do
    t=Order.reflect_on_association(:product)
    expect(t.macro).to eq(:belongs_to)
  end
  it  "has many to order_item" do
    t=Order.reflect_on_association(:order_items)
    expect(t.macro).to eq(:has_many)
  end
end
end
