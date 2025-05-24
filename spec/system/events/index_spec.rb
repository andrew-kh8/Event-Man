require 'rails_helper'

RSpec.describe 'index events', type: :system do
  let!(:first_event) { create(:event, name: 'Обучение дыханию маткой') }
  let!(:second_event) { create(:event, name: 'Книжный клуб') }
  let!(:third_event) { create(:event, name: 'Обучение кошек садоводству') }

  it 'shows all events' do
    visit event_list_path

    expect(page).to have_content(first_event.name)
      .and have_content(second_event.name)
      .and have_content(third_event.name)

    expect(page).to have_link(href: organization_event_path(first_event.organization_id, first_event.id))
      .and have_link(href: organization_event_path(second_event.organization_id, second_event.id))
      .and have_link(href: organization_event_path(third_event.organization_id, third_event.id))
  end

  context 'when find by name' do
    it 'shows events by name' do
      visit event_list_path

      find_by_id('event_name').fill_in(with: 'чение')
      click_button('Поиск')

      expect(page).to have_content(first_event.name)
        .and have_content(third_event.name)
        .and have_no_content(second_event.name)

      find_by_id('event_name').fill_in(with: 'клуб')
      click_button('Поиск')

      expect(page).to have_content(second_event.name)
        .and have_no_content(first_event.name)
        .and have_no_content(third_event.name)
    end
  end

  context 'when find by tag' do
    let(:first_event_tag) { 'first tag' }
    let(:second_event_tag) { 'second tag' }

    before do
      first_event.tag_list = [first_event_tag, second_event_tag]
      first_event.save!

      second_event.tag_list = [first_event_tag]
      second_event.save!
    end

    it 'shows events by tag' do
      visit event_list_path

      select(first_event_tag, from: 'tom-select-it')
      click_button('Поиск')

      expect(page).to have_content(first_event.name)
        .and have_content(second_event.name)
        .and have_no_content(third_event.name)

      click_link('Убрать тег')
      select(second_event_tag, from: 'tom-select-it')
      click_button('Поиск')

      expect(page).to have_content(first_event.name)
        .and have_no_content(second_event.name)
        .and have_no_content(third_event.name)
    end
  end

  context 'when find by name and tag' do
    let(:first_event_tag) { 'first tag' }

    before do
      first_event.tag_list = [first_event_tag]
      first_event.save!
    end

    it 'shows events by name and tag' do
      visit event_list_path

      find_by_id('event_name').fill_in(with: 'чение')
      select(first_event_tag, from: 'tom-select-it')
      click_button('Поиск')

      expect(page).to have_content(first_event.name)
        .and have_no_content(second_event.name)
        .and have_no_content(third_event.name)
    end
  end
end
