class NotificationsController < ApplicationController
  include Pagy::Backend
  include Authenticator

  before_action :authenticate_user

  # GET /person/notifications
  def index
    person = Person.find(params[:person_id])
    @pagy, @notifications = pagy(person.notifications.includes(:author).order(created_at: :desc))
  end
end
