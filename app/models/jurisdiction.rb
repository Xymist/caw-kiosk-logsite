class Jurisdiction < ApplicationRecord
  has_many :kiosks
  has_and_belongs_to_many :users
  has_and_belongs_to_many :logos

  validates_presence_of :name, :telephone, :pbx_server
end
