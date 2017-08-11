json.array!(@questions) do |question|
  json.extract! question, :id, :content, :source, :year
  json.url question_url(question, format: :json)
end
