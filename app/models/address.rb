class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  belongs_to :addressable, polymorphic: true, optional: true
end
