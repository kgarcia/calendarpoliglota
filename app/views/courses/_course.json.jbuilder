json.extract! course, :id, :name, :description, :start_time, :days, :city_id, :created_at, :updated_at
json.url course_url(course, format: :json)
