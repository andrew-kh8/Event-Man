# frozen_string_literal: true

class StarredOrganizationsController < ApplicationController
  EMPTY_STR = ''

  before_action :set_organization_id

  def create
    add_organization_id_to_cookie

    StarredOrganization.create(person: current_person, organization_id: @organization_id) if person_signed_in?

    render partial: 'starred_organizations/filled_star', locals: { organization: Organization.find(@organization_id) }
  end

  def destroy
    cookies[:starred_organizations] = cookies[:starred_organizations].sub(oid_to_cookie, EMPTY_STR)

    StarredOrganization.destroy_by(person: current_person, organization_id: @organization_id) if person_signed_in?

    render partial: 'starred_organizations/empty_star', locals: { organization: Organization.find(@organization_id) }
  end

  private

  def set_organization_id
    @organization_id = params[:organization_id]
  end

  def add_organization_id_to_cookie
    cookies[:starred_organizations] = EMPTY_STR if cookies[:starred_organizations].nil?

    cookies[:starred_organizations] += oid_to_cookie if cookies[:starred_organizations].exclude?(oid_to_cookie)
  end

  def oid_to_cookie
    ".#{@organization_id}."
  end
end
