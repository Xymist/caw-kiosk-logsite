class Jurisdiction < ApplicationRecord
  has_many :kiosks
  has_and_belongs_to_many :users
end
