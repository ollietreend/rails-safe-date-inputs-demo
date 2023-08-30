json.extract! person, :id, :name, :date_of_birth, :created_at, :updated_at
json.url person_url(person, format: :json)
