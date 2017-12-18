json.extract! person, :id, :name, :busy, :created_at, :updated_at
json.url person_url(person, format: :json)
