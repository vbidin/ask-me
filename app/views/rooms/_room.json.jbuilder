json.extract! room, :id, :name, :open, :created_at, :updated_at
json.url room_url(room, format: :json)
