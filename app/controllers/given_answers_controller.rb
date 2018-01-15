class GivenAnswersController < ApplicationController

  def index
    @given_answers = GivenAnswer.all
  end

  # GET /given_answers/1
  # GET /given_answers/1.json
  def show
    id = params['id']
    question = Question.where(id: id).first
    answers = Answer.where(question_id: id)

    counter = []
    answers.each { |a| counter.append(GivenAnswer.where(answer_id: a.id).count) }

    data = { 
      labels: answers.map { |a| a.data },
      datasets: [{
        label: 'given answers',
        data: counter
      }]
    }

    render json: { type: "bar", data: data }
  end

  # POST /messages
  # POST /messages.json
  def create
    @given_answer = GivenAnswer.new(given_answer_params)
    
    respond_to do |format|
      if @given_answer.save
        # broadcast to all people in the same room
        format.json
      else

      end
    end
  end

  private
    def given_answer_params
      params.require(:given_answer).permit(:user_id, :answer_id)
    end
end
