class KioskTopic < ApplicationRecord
  has_and_belongs_to_many :jurisdictions
end
