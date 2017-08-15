class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @question = Question.new
    Question.number_of_answers.times { @question.answers.build }
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to pages_home_path }
      format.json { head :no_content }
    end
  end

  private

  def require_same_user
    if current_user != @question.user && !current_user.admin?
      redirect_to pages_home_path
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:user_id, :content, :source, :year, :status,
                                     answers_attributes: [:id, :content, :correct])
  end
end
