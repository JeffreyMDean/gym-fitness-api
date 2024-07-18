class User < ApplicationRecord
  has_many :routines
  has_many :exercises, through: :routines
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :achievements
end
