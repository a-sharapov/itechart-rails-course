json.extract! user_person, :id, :name, :relation, :description, :user_id, :created_at, :updated_at
json.url user_person_url(user_person, format: :json)
