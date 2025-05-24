require 'rails_helper'

RSpec.describe 'New event', type: :system do
  let(:organization) { create(:organization) }

  context 'when organization signed in' do
    before { login_as(organization, scope: :organization) }

    context 'when open a page' do
      it 'shows all fields' do
        visit new_organization_event_path(organization)

        expect(page).to have_content('Название')
          .and have_content('Дата начала')
          .and have_content('Дата окончания')
          .and have_content('Онлайн')
          .and have_content('Теги (через запятую)')
          .and have_content('Описание')
          .and have_content('Изображение')
          .and have_content('Расположение')
          .and have_button('Создать событие')
          .and have_content('Назад')
      end
    end
  end
end
