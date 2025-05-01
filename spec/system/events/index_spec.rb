require 'rails_helper'

RSpec.describe 'index events', type: :system do
  let!(:first_event) { create(:event) }
  let!(:second_event) { create(:event) }
  let!(:third_event) { create(:event) }

  it 'shows all events' do
    visit event_list_path

    expect(page).to have_content(first_event.name)
      .and have_content(second_event.name)
      .and have_content(third_event.name)

    expect(page).to have_link(href: organization_event_path(first_event.organization_id, first_event.id))
      .and have_link(href: organization_event_path(second_event.organization_id, second_event.id))
      .and have_link(href: organization_event_path(third_event.organization_id, third_event.id))
  end
end
