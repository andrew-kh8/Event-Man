class EventsController < ApplicationController
  before_action :set_organization

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show; end

  # GET /events/new
  def new
    @event = @organization.events.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  def create
    @event = @organization.events.new(event_params)

    if @event.save
      redirect_to organization_event_path(@organization, @event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.', status: :see_other
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
    params.expect(event: %i[name description image start_date end_date])
  end
end
