class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def to_s
    return user.to_s + "@" + room.to_s + " - " + text
  end
end
