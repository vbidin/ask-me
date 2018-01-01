class Room < ApplicationRecord
  has_many :users, through: :permissions
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  attr_reader :role
  attr_writer :role

  def closed
    return !open
  end

  def to_s
    return name
  end
end
