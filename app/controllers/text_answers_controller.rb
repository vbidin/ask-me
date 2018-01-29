class TextAnswersController < ApplicationController

    def index
      @text_answers = TextAnswers.all
    end
  
    # GET /text_answers/1
    # GET /text_answers/1.json
    def show
      id = params['id']
      question = Question.where(id: id).first
      answers = TextAnswer.where(question_id: id)
      
      data = []
      answers.each { |a| data.append([User.where(id: a.user_id).first['username'], a.text])}
      render json: { answers: data }
      
    end
  
    # POST /messages
    # POST /messages.json
    def create

      @text_answer = TextAnswer.new(text_answer_params)
      @question = Question.where(id: @text_answer.question_id).first

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
        params.require(:text_answer).permit(:user_id, :question_id, :text)
      end
  end
  