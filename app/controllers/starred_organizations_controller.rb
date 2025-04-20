class StarredOrganizationsController < ApplicationController
  # POST /starred_organizations
  def create
    organization_id = params[:organization_id]

    cookies[:starred_organizations] = '' if cookies[:starred_organizations].nil?
    if cookies[:starred_organizations].exclude?(".#{organization_id}.")
      cookies[:starred_organizations] += ".#{organization_id}."
    end

    StarredOrganization.create(person: current_person, organization_id:) if person_signed_in?

    render partial: 'starred_organizations/filled_star', locals: { organization: Organization.find(organization_id) }
  end

  # DELETE /starred_organizations
  def destroy
    organization_id = params[:organization_id]
    cookies[:starred_organizations] = cookies[:starred_organizations].sub(".#{organization_id}.", '')

    StarredOrganization.destroy_by(person: current_person, organization_id:) if person_signed_in?

    render partial: 'starred_organizations/empty_star', locals: { organization: Organization.find(organization_id) }
  end
end
