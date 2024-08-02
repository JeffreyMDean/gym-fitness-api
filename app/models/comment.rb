class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :exercise

  validates :body, presence: true
  validates :user, presence: true
  validates :exercise, presence: true
end
