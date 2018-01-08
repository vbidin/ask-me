class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :text, presence: true, length: { minimum: 1 }

  def to_s
    return user.to_s + "@" + room.to_s + " - " + text
  end
end
