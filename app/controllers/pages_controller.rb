class PagesController < ApplicationController

  def home
    @questions = current_user.admin? ? Question.all : Question.by_user_id(current_user.id)
    @pending   = @questions.pending
    @approved  = @questions.approved
    @reproved  = @questions.reproved
  end
end
