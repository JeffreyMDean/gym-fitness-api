class Achievement < ApplicationRecord
  belongs_to :user, optional: true
end
