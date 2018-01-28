class Type < ApplicationRecord
  has_many :questions

  class << self

    def choice
      new(name: "choice")
    end

    def multiple_choice
      new(name: "multiple choice")
    end

    def text
      new(name: "text")
    end
  end

  def to_s
    return name
  end
end
