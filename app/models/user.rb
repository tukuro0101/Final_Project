class User < ApplicationRecord
  has_many :addresses
  has_many :orders
  has_many :reviews
  has_one :cart
  has_secure_password
end
