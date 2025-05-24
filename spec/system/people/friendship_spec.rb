# spec/system/user_profile_spec.rb
require 'rails_helper'

RSpec.describe 'Friendship request', type: :system do
  let(:person) { create(:person) }
  let(:friend) { create(:person) }

  before { login_as(person, scope: :person) }

  context 'when user wanna make friend' do
    it 'creates a friend request' do
      visit person_path(friend)

      expect(page).to have_button('Добавить в друзья')
      click_button('Добавить в друзья')

      expect(find_by_id('buttons')).to have_button('Отменить заявку')
      click_button('Отменить заявку')

      expect(find_by_id('buttons')).to have_button('Добавить в друзья')
    end
  end

  context 'when there is the friendship request' do
    before { create(:friendship, author: person, follower: friend, not_approved_id: person.id) }

    it 'accepts friendship' do
      visit person_path(friend)

      expect(page).to have_button('Принять в друзья')
      expect(page).to have_button('Не принимать в друзья')

      click_button('Принять в друзья')
      expect(page).to have_button('Удалить из друзей')
    end

    it 'declines friendship' do
      visit person_path(friend)

      expect(page).to have_button('Принять в друзья')
      expect(page).to have_button('Не принимать в друзья')

      click_button('Не принимать в друзья')
      expect(page).to have_button('Добавить в друзья')
    end
  end

  context 'when person wanna splits up' do
    before { create(:friendship, author: person, follower: friend) }

    it 'deletes friendship' do
      visit person_path(friend)

      expect(page).to have_button('Удалить из друзей')
      click_button('Удалить из друзей')

      expect(page).to have_button('Принять в друзья')
      expect(page).to have_button('Не принимать в друзья')
    end
  end
end
