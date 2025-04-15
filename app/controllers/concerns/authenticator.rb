module Authenticator
  extend ActiveSupport::Concern

  def authenticate_user
    if person_signed_in? || organization_signed_in?
      current_person || current_organization
    else
      authenticate_person!
    end
  end
end
