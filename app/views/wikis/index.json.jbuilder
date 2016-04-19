json.array!(@wikis) do |wiki|
  json.extract! wiki, :id, :title, :body, :private, :user_id
  json.url wiki_url(wiki, format: :json)
end
