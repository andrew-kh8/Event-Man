require 'rails_helper'

RSpec.describe 'index organizations', type: :system do
  let!(:first_organization) { create(:organization) }
  let!(:second_organization) { create(:organization) }
  let!(:third_organization) { create(:organization) }

  it 'shows all organizations' do
    visit organizations_path

    expect(page).to have_content(first_organization.name)
      .and have_content(second_organization.name)
      .and have_content(third_organization.name)

    expect(page).to have_link(href: organization_path(first_organization.id))
      .and have_link(href: organization_path(second_organization.id))
      .and have_link(href: organization_path(third_organization.id))
  end
end
