class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def devise_parameter_sanitizer
    if resource_class == Organization
      OrganizationParams.new(Organization, :organization, params)
    else
      super # Use the default one
    end
  end
end
