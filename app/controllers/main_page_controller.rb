class MainPageController < ApplicationController
  include Pagy::Backend

  def index; end

  def event_list
    @pagy, @events = pagy(Event.all)
    render partial: 'event_list'
  end

  def map
    render partial: 'map'
  end
end
