class Topic < ApplicationRecord
  belongs_to :host
  has_many :visits
end
