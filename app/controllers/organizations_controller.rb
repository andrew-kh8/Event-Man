class OrganizationsController < ApplicationController
  include Pagy::Backend

  before_action :set_organization, only: %i[edit update destroy]
  before_action :authenticate_organization!, only: %i[edit update destroy]

  def index
    organizations = find_organization
    organizations = select_favorite_organizations(organizations) if params[:favorite] == 'true'

    @pagy, @organizations = pagy(organizations)
  end

  def show
    @organization = Organization.includes(:events).find(params[:id])
  end

  def edit; end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Организация успешно обновлена', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy!
    redirect_to organizations_path, notice: 'Организация была полностью удалена', status: :see_other
  end

  private

  def set_organization
    @organization = Organization.find(params.expect(:id))
  end

  def organization_params
    params.expect(organization: %i[name description activity_field logo])
  end

  def find_organization
    if params[:organization_name]
      Organization.where('name ILIKE ?', "%#{params[:organization_name]}%")
    else
      Organization.all
    end
  end

  def select_favorite_organizations(organizations)
    fav_ids = []

    fav_ids += cookies[:starred_organizations].gsub(/[0-9]*/).compact_blank if cookies[:starred_organizations].present?

    if person_signed_in?
      fav_ids += current_person.starred_organizations.select(:organization_id).pluck(:organization_id)
    end

    organizations.where(id: fav_ids)
  end
end
