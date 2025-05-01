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
end
