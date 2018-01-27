class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    # GET /users
    # GET /users.json
    def index
      @users = User.all
    end
  
    # GET /users/1
    # GET /users/1.json
    def show
      id = params['id']
      given_answers = GivenAnswer.where(user_id: id)

      trueAnswers = 0
      falseAnswers = 0
      given_answers.each { |a| 
        answers = Answer.where(id: a.answer_id)
        if answers[0][:correct] == false
          falseAnswers += 1
        elsif 
          trueAnswers += 1
        end
      }
      print falseAnswers
      print trueAnswers
  
      data = { 
        labels: ["False answers", "True answers"],
        datasets: [{
          label: 'User answers',
          data: [falseAnswers, trueAnswers],
          backgroundColor: [
                'rgba(255, 182, 0, 0.30)',
                'rgba(0, 255, 212, 0.30)'
            ]
        }]
      }
  
      render json: { type: "pie", data: data }
    end
  
    # GET /users/new
    def new
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # POST /users
    # POST /users.json
    def create
    end
  
    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
    end
  
    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user)
    end
  end
  