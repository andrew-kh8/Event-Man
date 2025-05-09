require 'rails_helper'

RSpec.describe 'show event', type: :system do
  let(:event) { create(:event) }
  let(:organization) { event.organization }
  let(:first_event_tag) { 'first tag' }
  let(:second_event_tag) { 'second tag' }

  before do
    event.tag_list = [first_event_tag, second_event_tag]
    event.save!
  end

  it 'show event page' do
    visit organization_event_path(organization, event)

    expect(page).to have_content(event.name.upcase)
      .and have_link(organization.name, href: organization_path(organization))
      .and have_content("Участников: #{event.participants.size}")
      .and have_content('01.05.2025 - 01.05.2025')
      .and have_content('20:33 - 22:00')
      .and have_content('(Офлайн)')
      .and have_content(first_event_tag)
      .and have_content(second_event_tag)
  end

  context 'when person signed in' do
    let(:person) { create(:person) }

    before { login_as(person) }

    it 'show event with ability to take part' do
      visit organization_event_path(organization, event)

      expect(page).to have_content('Записаться')
        .and have_content('Вы не записаны')

      click_button('Записаться')
      expect(page).to have_content('Вы записаны')
        .and have_content('Отменить участие')

      refresh
      expect(page).to have_content('Вы записаны')
        .and have_content('Отменить участие')

      click_button('Отменить участие')
      expect(page).to have_content('Записаться')
        .and have_content('Вы не записаны')

      refresh
      expect(page).to have_content('Записаться')
        .and have_content('Вы не записаны')
    end

    context 'when person has a friend' do
      let(:friend) { create(:person) }
      let!(:friendship) { create(:friendship, author: person, follower: friend) }

      it 'has ability to invite friend' do
        visit organization_event_path(organization, event)

        expect(page).to have_content('Записаться')
          .and have_content('Вы не записаны')
          .and have_button('Пригласить друга')

        select(friend.full_name, from: 'participants[person_id]')
        click_button('Пригласить друга')
      end
    end
  end
end
