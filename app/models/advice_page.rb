class AdvicePage < ApplicationRecord
  serialize :kiosks
  has_and_belongs_to_many :kiosks
  mount_uploader :image, ImageUploader
end
