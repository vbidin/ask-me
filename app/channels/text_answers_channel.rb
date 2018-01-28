class TextAnswersChannel < ApplicationCable::Channel  
    def subscribed
      stream_from 'text_answers'
    end
  end  