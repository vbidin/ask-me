class GivenAnswersController < ApplicationController
  before_action :set_given_answer, only: [:show, :edit, :update, :destroy]

  def index
    @given_answers = GivenAnswer.all
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
