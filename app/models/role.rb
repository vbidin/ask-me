class Role < ApplicationRecord
  has_many :permissions

  class << self
    def default
      new(name: "Guest")
    end

    def guest
      new(name: "Guest")
    end

    def moderator
      new(name: "Moderator")
    end

    def admin
      new(name: "Admin")
    end
  end

  def to_s
    return name
  end

end
