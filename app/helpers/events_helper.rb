module EventsHelper
  def dates(event)
    [event.start_date.strftime('%d.%m.%Y'), event.end_date.strftime('%d.%m.%Y')].join(' - ')
  end

  def time(event)
    [event.start_date.strftime('%H:%M'), event.end_date.strftime('%H:%M')].join(' - ')
  end

  def online(event)
    event.online ? '(Онлайн)' : '(Офлайн)'
  end
end
