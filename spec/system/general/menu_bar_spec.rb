require 'rails_helper'

RSpec.describe 'menu bar', type: :system do
  it 'shows all links' do
    visit root_path

    expect(page).to have_link('Event Man', href: root_path)
      .and have_link('Мероприятия', href: root_path)
      .and have_link('Организации', href: organizations_path)
      .and have_no_content('Пользователи')
      .and have_no_content('Моя организация')
      .and have_no_content('Мой профиль')

    expect(page.find(:css, 'form[action="/people/sign_in"]')).to have_button('Войти')
  end
end
