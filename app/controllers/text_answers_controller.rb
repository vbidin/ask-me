class TextAnswersController < ApplicationController

    def index
      @text_answers = TextAnswers.all
    end
  
    # GET /text_answers/1
    # GET /text_answers/1.json
    def show
    end
  
    # POST /messages
    # POST /messages.json
    def create
      @text_answer = TextAnswers.new(given_answer_params)
      @question = Question.where(id: @answer.question_id).first
      
      respond_to do |format|
        if @text_answer.save
          ActionCable.server.broadcast 'text_answer', @question
          format.json
        else
  
        end
      end
    end
  
    private
      def text_answer_params
        params.require(:text_answer).permit(:user_id, :question_id)
      end
  end
  