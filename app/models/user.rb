class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  validates :email, presence: true, uniqueness: true
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :cart, dependent: :destroy
  attribute :admin, :boolean, default: false
  def admin?
    self.admin
  end
end
