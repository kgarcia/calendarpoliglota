class Course < ApplicationRecord
  belongs_to :city
  has_many :events

  enum days: { mon_wed: 0, tue_thu: 1}

   
    def create_events(new_date)
        8.times do |index|
          weekday = new_date.wday
          Event.create(date: new_date, number: index+1, course_id: self.id)
          
          new_date = new_date+next_day(weekday).days
        end
    end

    def update_events(new_date)
      self.events.each do |event|
        weekday = new_date.wday
        event.update(date: new_date)
        new_date = new_date+next_day(weekday).days
      end
    end

    def next_day(weekday)
      case
      when (1..2) === weekday
        return 2
      when (3..4) === weekday
        return 5
      end
    end
end
