class Question < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :type

  def to_s
    return title
  end
end
