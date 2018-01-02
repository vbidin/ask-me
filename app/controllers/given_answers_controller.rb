class GivenAnswersController < ApplicationController
  before_action :set_given_answer, only: [:show, :edit, :update, :destroy]

  def index
    @given_answers = GivenAnswer.all
  end
end
