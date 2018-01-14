class Question < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :type

  validates :title, presence: true, uniqueness: true

  def to_s
    return title
  end
end
