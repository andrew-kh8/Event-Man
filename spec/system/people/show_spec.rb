# spec/system/user_profile_spec.rb
require 'rails_helper'

RSpec.describe 'User Profile', type: :system do
  let(:person) { create(:person) }
  let(:friend) { create(:person, description: FFaker::Lorem.sentence) }

  before { login_as(person, scope: :person) }

  context 'when it is a brand new user' do
    it 'show general person data' do
      visit person_path(friend)

      expect(page).to have_content(friend.full_name)
        .and have_content(friend.city)
        .and have_content(friend.description)

      expect(find_by_id('friends_stat')).to have_link(href: people_path(params: { friends: friend.id }))
        .and have_content(0)
        .and have_content('Друзей')

      expect(find_by_id('events_stat')).to have_content(0)
        .and have_content('Мероприятий')

      expect(find_by_id('registry_stat')).to have_content(Date.current.strftime('%d.%m.%y'))
        .and have_content('Регистрация')

      expect(find_by_id('buttons')).to have_button('Добавить в друзья')

      expect(find_by_id('description')).to have_content('Обо мне')
        .and have_content(friend.description)

      expect(find_by_id('events')).to have_content('Пока мероприятий нет')

      expect(find_by_id('friends')).to have_content('Друзья (0)')
        .and have_link(href: people_path(params: { friends: friend.id }))
    end
  end

  context 'when user wanna make friend' do
    it 'creates a friend request' do
      expect(page).to have_button('Добавить в друзья')
      click_button('Добавить в друзья')

      expect(find_by_id('buttons')).to have_button('Отменить заявку')
      click_button('Отменить заявку')

      expect(find_by_id('buttons')).to have_button('Добавить в друзья')
    end
  end

  # 'Sending a friend request'
  # 'Accepting a friend request'
  # 'Declining a friend request'
  # 'Removing a friend'
  # 'Viewing person friends'
  # 'Viewing person events'
  # 'Setting event privacy'
end
