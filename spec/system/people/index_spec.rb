require 'rails_helper'

RSpec.describe 'index people', type: :system do
  let!(:first_person) { create(:person, first_name: 'Nick', last_name: 'Brown') }
  let!(:second_person) { create(:person, first_name: 'John', last_name: 'Nickelback') }
  let!(:third_person) { create(:person, first_name: 'Amanda', last_name: 'Smith') }

  before { login_as(first_person, scope: :person) }

  it 'shows all people' do
    visit people_path

    expect(page).to have_content(first_person.first_name)
      .and have_content(second_person.first_name)
      .and have_content(third_person.first_name)

    expect(page).to have_link(href: person_path(first_person.id))
      .and have_link(href: person_path(second_person.id))
      .and have_link(href: person_path(third_person.id))
  end

  context 'when find by first name' do
    it 'shows people by first name' do
      visit people_path

      find_by_id('person_name').fill_in(with: 'Nick')
      click_button('Поиск')

      expect(page).to have_content(first_person.first_name)
        .and have_content(second_person.first_name)
        .and have_no_content(third_person.first_name)
    end
  end

  context 'when find by last name' do
    it 'shows people by last name' do
      visit people_path

      find_by_id('person_name').fill_in(with: 'Smith')
      click_button('Поиск')

      expect(page).to have_content(third_person.first_name)
        .and have_no_content(first_person.first_name)
        .and have_no_content(second_person.first_name)
    end
  end
end
