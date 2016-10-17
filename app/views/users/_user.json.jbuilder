json.extract! user, :id, :name, :email, :nusp, :created_at, :updated_at
json.url user_url(user, format: :json)