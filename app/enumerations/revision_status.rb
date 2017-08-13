class RevisionStatus < EnumerateIt::Base
  associate_values :approved, :reproved
end
