class QuestionStatus < EnumerateIt::Base
  associate_values :approved, :pending, :reproved
end
