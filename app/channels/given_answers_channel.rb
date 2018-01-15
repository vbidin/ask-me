class GivenAnswersChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'given_answers'
  end
end  