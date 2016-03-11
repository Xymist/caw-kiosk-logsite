class Kiosk < ApplicationRecord
  has_many :heartbeats
  has_many :visits
end
