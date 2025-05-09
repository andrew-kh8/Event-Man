require 'rails_helper'

RSpec.describe 'show organization', type: :system do
  let!(:organization) { create(:organization) }
  let!(:first_event) { create(:event, organization:) }
  let!(:second_event) { create(:event, organization:) }
  let!(:third_event) { create(:event, organization:) }

  it 'shows organization' do
    visit organization_path(organization)

    expect(page).to have_content(organization.name)
      .and have_content(organization.activity_field)
      .and have_content(organization.description)
      .and have_no_content('Добавить мероприятие')
      .and have_no_content('Пройти аккредитацию')
      .and have_no_content('Редактировать')
      .and have_no_content('Выйти')

    expect(page).to have_link(href: organization_event_path(organization, first_event.id))
      .and have_link(href: organization_event_path(organization, second_event.id))
      .and have_link(href: organization_event_path(organization, third_event.id))
  end

  context 'when organization is sign in' do
    let!(:another_org) { create(:organization) }

    before { login_as(organization, scope: :organization) }

    it 'shows settings buttons' do
      visit organization_path(organization)

      expect(page).to have_content(organization.name)
        .and have_content(organization.activity_field)
        .and have_content(organization.description)
        .and have_no_content('Добавить мероприятие')
        .and have_content('Пройти аккредитацию')
        .and have_content('Редактировать')
        .and have_button('Выйти')

      visit organization_path(another_org)

      expect(page).to have_content(another_org.name.upcase)
        .and have_no_content('Добавить мероприятие')
        .and have_no_content('Пройти аккредитацию')
        .and have_no_content('Редактировать')
        .and have_no_content('Выйти')
    end
  end
end
