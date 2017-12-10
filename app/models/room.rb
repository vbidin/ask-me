class Room < ApplicationRecord
  has_many :permissions
  has_many :questions
end
