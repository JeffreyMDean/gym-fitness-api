class Achievement < ApplicationRecord
  belongs_to :user, optional: true

  validates :user_id, prescence: true
  validates :badge, prescence: true
  validates :description, prescence: true
end
