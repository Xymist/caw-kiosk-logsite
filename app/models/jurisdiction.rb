class Jurisdiction < ApplicationRecord
  has_many :kiosks
  has_and_belongs_to_many :users
  has_and_belongs_to_many :logos
  has_and_belongs_to_many :kiosk_topics

  validates_presence_of :name
end
