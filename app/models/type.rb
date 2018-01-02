class Type < ApplicationRecord
  has_many :questions

  class << self
    def yes_no
      new(name: "yes/no")
    end

    def choice
      new(name: "choice")
    end

    def multiple_choice
      new(name: "multiple choice")
    end
  end

  def to_s
    return name
  end
end
