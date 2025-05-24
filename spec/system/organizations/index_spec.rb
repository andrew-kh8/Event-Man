require 'rails_helper'

RSpec.describe 'index organizations', type: :system do
  let!(:first_organization) { create(:organization, name: 'First name (1)') }
  let!(:second_organization) { create(:organization, name: 'Second name second') }
  let!(:third_organization) { create(:organization, name: 'C.K. & Co.') }

  it 'shows all organizations' do
    visit organizations_path

    expect(page).to have_content(first_organization.name)
      .and have_content(second_organization.name)
      .and have_content(third_organization.name)

    expect(page).to have_link(href: organization_path(first_organization.id))
      .and have_link(href: organization_path(second_organization.id))
      .and have_link(href: organization_path(third_organization.id))
  end

  context 'when find by name' do
    it 'shows organizations by name' do
      visit organizations_path

      find_by_id('organization_name').fill_in(with: 'name')
      click_button('Поиск')

      expect(page).to have_content(first_organization.name)
        .and have_content(second_organization.name)
        .and have_no_content(third_organization.name)

      find_by_id('organization_name').fill_in(with: 'C.K')
      click_button('Поиск')

      expect(page).to have_content(third_organization.name)
        .and have_no_content(first_organization.name)
        .and have_no_content(second_organization.name)
    end
  end
end
