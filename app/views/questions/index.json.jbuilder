json.array!(@questions) do |question|
  json.extract! question, :id, :content, :source, :year, :status
  json.url question_url(question, format: :json)
end
