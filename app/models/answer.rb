class Answer < ApplicationRecord
  belongs_to :question

  def to_s
    return data
  end
end
