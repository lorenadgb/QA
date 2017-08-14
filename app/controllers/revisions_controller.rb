class RevisionsController < ApplicationController
  before_action :require_same_user, only: [:new]

  def new
    @revision = Revision.new
    @question = Question.find(params[:question_id])
    @revision.question = @question
  end

  def create
    @revision = Revision.new(revision_params)

    respond_to do |format|
      if @revision.save
        format.html { redirect_to new_revision_path(question_id: @revision.question_id), notice: 'Revision was successfully created.' }
        format.json { render action: 'new', status: :created, location: @revision }
      else
        format.html { render action: 'new' }
        format.json { render json: @revision.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def require_same_user
    @question = Question.find(params[:question_id])

    if current_user != @question.user && !current_user.admin?
      redirect_to pages_home_path
    end
  end

  def revision_params
    params.require(:revision).permit(:comment, :status, :reviewer_id, :question_id)
  end
end
