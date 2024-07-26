class AddEmailToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :email, :string
  end
end
