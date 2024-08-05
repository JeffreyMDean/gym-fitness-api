class User < ApplicationRecord
  has_many :routines
  has_many :exercises, through: :routines
  has_many :comments
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
