class MainPageController < ApplicationController
  include Pagy::Backend
  include Authenticator

  before_action :authenticate_user

  def index
    filtered_events = if params[:event_name].present?
                        Event.where('name ILIKE ?', ['%', params[:event_name], '%'].join)
                      else
                        Event.all
                      end

    @pagy, @events = pagy(filtered_events)
  end

  def event_list
    @pagy, @events = pagy(Event.includes(:organization).all)
    render partial: 'event_list'
  end

  def map
    render partial: 'map'
  end
end
