class MainPageController < ApplicationController
  include Pagy::Backend
  include Authenticator

  def index
    filtered_events = if params[:event_name].present?
                        Event.where('name ILIKE ?', ['%', params[:event_name], '%'].join)
                      else
                        Event.all
                      end

    filtered_events = filtered_events.tagged_with(search_tags, any: true) if params[:tag_list].present?
    @pagy, @events = pagy(filtered_events)
  end

  def event_list
    @pagy, @events = pagy(Event.includes(:organization).all)
    render partial: 'event_list'
  end

  def map
    render partial: 'map'
  end

  private

  def search_tags
    params[:tag_list].compact_blank
  end
end
