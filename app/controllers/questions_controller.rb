class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @type = Type.where(id: @question.type_id).first
    @answers = Answer.where(question_id: @question.id)

    # check if user already answered the question
    answered = false
    for a in @answers
      given_answer = GivenAnswer.where(user_id: current_user.id, answer_id: a.id)
      if (given_answer.exists?)
        answered = true
        break
      end
    end

    # if true load the given answers
    given_answers = []
    if (answered)
      for a in @answers
        given_answers.append(GivenAnswer.where(user_id: current_user.id, answer_id: a.id).first)
      end
    end

    render :json => { :question => @question, 
                      :answers => @answers, 
                      :type => @type, 
                      :answered => answered,
                      :given_answers => given_answers }
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        ActionCable.server.broadcast 'questions', @question
        format.json { render json: @question }
      else
        format.json { render json: @question.errors.full_messages.to_s, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id, :room_id, :type_id, :title, :text, :visible, :locked)
    end
end
