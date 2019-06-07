class Car < ApplicationRecord
  has_many :reservation
  validates_presence_of :model, :mark, :targa, :price, uniqueness: true
end
