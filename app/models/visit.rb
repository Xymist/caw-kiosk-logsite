class Visit < ApplicationRecord
  belongs_to :topic
  belongs_to :kiosk
  has_one    :host, through: :topic
  validates_uniqueness_of :checksum
end
