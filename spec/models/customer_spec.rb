require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    context "invalid cases" do
    it "should not validate without presence_of name" do
      customer_without_name=Customer.new(address:"nashik",dob:"2000-02-02",phone_number:1111111111)
      expect(customer_without_name).to_not be_valid
    end
    it "should not validate without presence_of address" do
      customer_without_address=Customer.new(name:"Harsh",dob:"2000-02-02",phone_number:1111111111)
      expect(customer_without_address).to_not be_valid
    end
    it "should not validate without presence_of dob" do
      customer_without_dob=Customer.new(name:"Harsh",address:"nashik",phone_number:1111111111)
      expect(customer_without_dob).to_not be_valid
    end
    it "should not validate without presence_of phone number" do
      customer_without_phone_number=Customer.new(name:"Harsh",dob:"2000-02-02",address:"Nashik")
      expect(customer_without_phone_number).to_not be_valid
    end
  end
  context "valid case " do
    it "all attr ar present" do
      customer_valid=Customer.new(name:"Harsh",address:"Nashik",dob:"2000-02-02",phone_number:1222222222,email:"Hahd@gmail.com",password:"123")
      expect(customer_valid).to be_valid
    end
  end
  end
  describe 'associations' do
    it "should have many orders" do
      t = Customer.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end
  end

end
