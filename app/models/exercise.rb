class Exercise < ApplicationRecord
  has_many :routines
  has_many :users, through: :routines
  has_many :comments
end
