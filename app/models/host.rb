class Host < ApplicationRecord
  has_many :topics
  has_many :visits, through: :topics
end
