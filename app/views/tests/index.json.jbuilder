json.array!(@tests) do |test|
  json.extract! test, :id, :description, :question, :alternative1, :alternative2, :alternative3, :alternative4, :answer
  json.url test_url(test, format: :json)
end
