class Customer < ApplicationRecord
  before_save { email.downcase! }
  has_many :orders
  has_many :products, through: :orders
  validates :name, :address, :dob, :phone_number, :email, presence:true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  has_secure_password
end
