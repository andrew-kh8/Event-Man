class AllEventsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @events = pagy(Event.all)
  end
end
