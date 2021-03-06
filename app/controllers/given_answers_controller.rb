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
      labels: answers.map { |a| a.correct ? a.data + " (+)" : a.data },
      datasets: [{
        label: 'given answers',
        data: counter,
        backgroundColor: [
                'rgba(255, 182, 0, 0.30)',
                'rgba(0, 255, 212, 0.30)',
                'rgba(255, 182, 0, 0.30)',
                'rgba(0, 255, 212, 0.30)',
                'rgba(255, 182, 0, 0.30)',
                'rgba(0, 255, 212, 0.30)'
            ]
      }]
    }

    render json: { type: "bar", data: data, options: {
      legend: {
         display: false
      },
      tooltips: {
         enabled: false
      }
 } }
  end

  # POST /messages
  # POST /messages.json
  def create
    @given_answer = GivenAnswer.new(given_answer_params)
    @answer = Answer.where(id: @given_answer.answer_id).first
    @question = Question.where(id: @answer.question_id).first
    
    respond_to do |format|
      if @given_answer.save
        ActionCable.server.broadcast 'given_answers', @question
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
