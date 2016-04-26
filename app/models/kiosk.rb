class Kiosk < ApplicationRecord
  has_many :heartbeats
  has_many :visits
  belongs_to :jurisdiction
  has_and_belongs_to_many :advice_pages
end
