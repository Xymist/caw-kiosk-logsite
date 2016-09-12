class FormResponse < ApplicationRecord
  belongs_to :kiosk
  validates :kiosk_id, presence: true
end
