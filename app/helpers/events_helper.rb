module EventsHelper
  def dates(event)
    [event.start_date.strftime('%d.%m.%Y %H:%M'), event.end_date.strftime('%d.%m.%Y %H:%M')].join(' - ')
  end
end
