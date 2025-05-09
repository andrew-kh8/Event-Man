require 'rails_helper'

RSpec.describe 'star organization', type: :system do
  let!(:organization) { create(:organization) }
  let!(:another_org) { create(:organization) }

  context 'when person not signed in' do
    it 'can be starred' do
      visit organization_path(organization)

      expect(page).to have_css('#empty_star')
      # check buttons and img
      click_button('empty_star')
      expect(page).to have_css('#filled_star')

      visit organization_path(another_org)
      expect(page).to have_css('#empty_star')

      visit organizations_path
      find('label', text: 'Избранные').click
      click_button('Поиск')
      expect(page).to have_content(organization.name.upcase)

      visit organization_path(organization)
      expect(page).to have_css('#filled_star')
      click_button('filled_star')
      expect(page).to have_css('#empty_star')

      refresh
      expect(page).to have_css('#empty_star')
    end
  end

  context 'when person is sign in' do
    let(:person) { create(:person) }

    before { login_as(person, scope: :person) }

    it 'can be starred' do
      visit organization_path(organization)

      expect(page).to have_content(organization.name.upcase)
      expect(page).to have_css('#empty_star')
      click_button('empty_star')
      expect(page).to have_css('#filled_star')

      visit organization_path(another_org)

      expect(page).to have_content(another_org.name.upcase)
      expect(page).to have_css('#empty_star')

      visit organization_path(organization)
      expect(page).to have_css('#filled_star')
    end
  end

  context 'when organization is sign in' do
    before { login_as(organization, scope: :organization) }

    it 'can not be starred' do
      visit organization_path(organization)

      expect(page).to have_content(organization.name.upcase)
      expect(page).to have_no_css('#filled_star')
      expect(page).to have_no_css('#empty_star')

      visit organization_path(another_org)

      expect(page).to have_content(another_org.name.upcase)
      expect(page).to have_no_css('#filled_star')
      expect(page).to have_no_css('#empty_star')
    end
  end
end
