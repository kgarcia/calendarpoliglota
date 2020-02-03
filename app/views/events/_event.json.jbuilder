json.extract! event, :id, :date, :number, :course_id, :created_at, :updated_at
json.url event_url(event, format: :json)
