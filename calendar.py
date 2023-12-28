from icalendar import Calendar, Event
from datetime import datetime, timedelta
import pytz

# Create a new calendar
cal = Calendar()

# Timezone for the events
tz = pytz.timezone('Australia/Brisbane')  # Brisbane timezone

# Function to add an event to the calendar
def add_event(summary, start_day, start_time, end_time, repeat_until, days_off=[]):
    event = Event()
    event.add('summary', summary)
    start_datetime = tz.localize(datetime(2023, 1, start_day, *start_time))
    end_datetime = tz.localize(datetime(2023, 1, start_day, *end_time))
    event.add('dtstart', start_datetime)
    event.add('dtend', end_datetime)
    event.add('rrule', {'freq': 'daily', 'until': tz.localize(datetime(2023, 1, repeat_until))})
    for day_off in days_off:
        event.add('exdate', tz.localize(datetime(2023, 1, day_off, *start_time)))
    cal.add_component(event)

# Adding the events
add_event("Exercise", 1, (7, 0), (7, 30), 20)  # Daily exercise
add_event("Studies", 1, (8, 0), (12, 0), 20, days_off=[7, 14, 21])  # Studies (excluding Sundays)
add_event("Job Search/Freelancing", 1, (13, 0), (17, 0), 20, days_off=[7, 8, 14, 15, 21, 22])  # Job Search (Mon-Wed)
add_event("Business Planning", 1, (13, 0), (17, 0), 20, days_off=[1, 2, 3, 7, 8, 14, 15, 21, 22])  # Business Planning (Thu-Fri)
add_event("Personal Development", 1, (18, 0), (20, 0), 20, days_off=[7, 14, 21])  # Personal Development (excluding Sundays)
add_event("Review and Plan", 1, (10, 0), (12, 0), 20, days_off=[1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 29, 30, 31])  # Review and Plan on Sundays

# Save the calendar to an .ics file
with open('my_schedule.ics', 'wb') as f:
    f.write(cal.to_ical())