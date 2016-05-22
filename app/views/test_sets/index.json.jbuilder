json.array!(@test_sets) do |test_set|
  json.extract! test_set, :id, :description, :video_url, :score
  json.url test_set_url(test_set, format: :json)
end
