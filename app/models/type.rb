class Type < ApplicationRecord
  has_many :questions

  class << self
    def yes_no
      new(name: "Yes/No")
    end

    def text_choice
      new(name: "Text choice")
    end

    def text_multiple_choice
      new(name: "Text multiple choice")
    end
  end

  def to_s
    return name
  end
end
