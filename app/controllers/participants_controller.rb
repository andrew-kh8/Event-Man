class ParticipantsController < ApplicationController
  # POST /participants
  def create
    @participant = Participant.new(participant_params)
    return render partial: 'destroy_button', notice: 'Participant was successfully created.' if @participant.save

    @event = @participant.event
    render partial: 'create_button', notice: 'ERROR'
  end

  # DELETE /participants/1
  def destroy
    participant = Participant.find(params[:id])
    @event = participant.event
    participant.destroy!
    render partial: 'create_button', notice: 'Participant was successfully destroyed.'
  end

  private

  def participant_params
    params.require(:participants).permit(%i[person_id event_id])
  end
end
