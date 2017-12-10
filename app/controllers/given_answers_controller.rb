class GivenAnswersController < ApplicationController
  before_action :set_given_answer, only: [:show, :edit, :update, :destroy]

  # GET /given_answers
  # GET /given_answers.json
  def index
    @given_answers = GivenAnswer.all
  end

  # GET /given_answers/1
  # GET /given_answers/1.json
  def show
  end

  # GET /given_answers/new
  def new
    @given_answer = GivenAnswer.new
  end

  # GET /given_answers/1/edit
  def edit
  end

  # POST /given_answers
  # POST /given_answers.json
  def create
    @given_answer = GivenAnswer.new(given_answer_params)

    respond_to do |format|
      if @given_answer.save
        format.html { redirect_to @given_answer, notice: 'Given answer was successfully created.' }
        format.json { render :show, status: :created, location: @given_answer }
      else
        format.html { render :new }
        format.json { render json: @given_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /given_answers/1
  # PATCH/PUT /given_answers/1.json
  def update
    respond_to do |format|
      if @given_answer.update(given_answer_params)
        format.html { redirect_to @given_answer, notice: 'Given answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @given_answer }
      else
        format.html { render :edit }
        format.json { render json: @given_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /given_answers/1
  # DELETE /given_answers/1.json
  def destroy
    @given_answer.destroy
    respond_to do |format|
      format.html { redirect_to given_answers_url, notice: 'Given answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_given_answer
      @given_answer = GivenAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def given_answer_params
      params.require(:given_answer).permit(:user_id, :answer)
    end
end
