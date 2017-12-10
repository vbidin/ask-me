json.extract! question, :id, :user_id, :room_id, :type_id, :title, :text, :visible, :locked, :created_at, :updated_at
json.url question_url(question, format: :json)
