class Kiosk < ApplicationRecord
  has_many :heartbeats
  has_many :visits
  has_many :form_responses
  belongs_to :jurisdiction
  has_and_belongs_to_many :advice_pages

  validates :name, :address, :contact, :jurisdiction_id, presence: true
end
