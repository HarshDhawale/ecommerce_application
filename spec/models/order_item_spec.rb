require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "assiciation" do
    it "belongs to product" do
      t=OrderItem.reflect_on_association(:product)
      expect(t.macro).to eq(:belongs_to)
  end
  it "belongs to order" do
    t=OrderItem.reflect_on_association(:order)
    expect(t.macro).to eq(:belongs_to)
end
  end
end
