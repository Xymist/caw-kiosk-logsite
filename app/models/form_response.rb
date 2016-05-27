class FormResponse < ApplicationRecord
  belongs_to :kiosk
  validates_presence_of :kiosk_id
end
