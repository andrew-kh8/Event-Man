class EventsController < ApplicationController
  before_action :set_organization

  def show
    @event = @organization.events.find(params[:id])
    @participant = Participant.find_by(person: current_person, event: @event)
  end

  def new
    @event = @organization.events.new
  end

  def edit
    @event = @organization.events.find(params[:id])
  end

  def create
    @event = @organization.events.new(event_params)
    @event.tag_list = event_tags if params[:event][:tag_list].present?

    if @event.save
      redirect_to organization_event_path(@organization, @event), notice: 'Событие успешно создано'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event = @organization.events.find(params[:id])
    @event.tag_list = event_tags if params[:event][:tag_list].present?

    if @event.update(event_params)
      redirect_to organization_event_path(@organization, @event), notice: 'Событие успешно обновлено',
                                                                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path, notice: 'Событие полностью удалено ', status: :see_other
  end

  private

  def set_organization
    @organization = Organization.find(params.expect(:organization_id))
  end

  def event_params
    data = params.expect(event: %i[name description image start_date end_date online])
    location = RGeo::Cartesian.factory(srid: Event::SRID).point(*params[:event][:location].split)

    data.merge({ location: })
  end

  def event_tags
    params[:event][:tag_list].split(',').map { _1.strip.downcase }.compact_blank
  end
end
