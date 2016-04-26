class AdvicePage < ApplicationRecord
  serialize :kiosks
  has_and_belongs_to_many :kiosks
end
