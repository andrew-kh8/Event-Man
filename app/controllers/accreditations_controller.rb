class AccreditationsController < ApplicationController
  before_action :authenticate_organization!

  def show
    organization = Organization.find(params[:organization_id])
    render 'accreditation/index', locals: { organization: }
  end
end
