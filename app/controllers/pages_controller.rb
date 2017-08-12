class PagesController < ApplicationController

  def home
    @questions = Question.all
    @pending   = @questions.pending
    @approved  = @questions.approved
    @reproved  = @questions.reproved
  end
end
