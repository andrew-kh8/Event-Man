class EventsController < ApplicationController
  before_action :set_organization

  def show
    @event = @organization.events.find(params[:id])
  end

  def new
    @event = @organization.events.new
  end

  def edit
    @event = @organization.events.find(params[:id])
  end

  def create
    @event = @organization.events.new(event_params)

    if @event.save
      redirect_to organization_event_path(@organization, @event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event = @organization.events.find(params[:id])
    if @event.update(event_params)
      redirect_to organization_event_path(@organization, @event), notice: 'Event was successfully updated.',
                                                                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
    redirect_to events_path, notice: 'Event was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params.expect(:organization_id))
  end

  # Only allow a list of trusted parameters through.
  def event_params
    data = params.expect(event: %i[name description image start_date end_date online])
    location = RGeo::Cartesian.factory(srid: Event::SRID).point(*params[:event][:location].split.reverse)

    data.merge({ location: })
  end
end
