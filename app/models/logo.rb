class Logo < ApplicationRecord
  has_and_belongs_to_many :jurisdictions
  mount_uploader :image, ImageUploader
end
