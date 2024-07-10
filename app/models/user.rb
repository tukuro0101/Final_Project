class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :reviews
  has_one :cart
  attribute :admin, :boolean, default: false
end
