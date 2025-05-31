class NotificationsController < ApplicationController
  include Pagy::Backend
  include Authenticator

  before_action :authenticate_user

  # rubocop:disable Rails::SkipsModelValidations
  after_action { @notifications&.update_all(read: true) }
  # rubocop:enable Rails::SkipsModelValidations

  def index
    person = Person.find(params[:person_id])
    @pagy, @notifications = pagy(person.notifications.includes(:author).order(created_at: :desc))
  end

  def destroy
    Notification.find(params[:id]).destroy
  end
end
