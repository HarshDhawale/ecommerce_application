class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.date :dob
      t.integer :age
      t.integer :phone_number

      t.timestamps
    end
  end
end
