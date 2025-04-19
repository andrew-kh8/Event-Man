class ParticipantsController < ApplicationController
  # POST /participants
  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      return render partial: 'destroy_button', locals: { participant: @participant },
                    notice: 'Participant was successfully created.'
    end

    render partial: 'create_button', locals: { event: @participant.event }, notice: 'ERROR'
  end

  # PUT /participants/1
  def update
    participant = Participant.find(params[:id])
    participant.update!(visible: params[:participants][:visible])

    render partial: "people/#{params[:participants][:visible]}_visible_icon", locals: { participant: }
  end

  # DELETE /participants/1
  def destroy
    participant = Participant.find(params[:id])
    participant.destroy!

    render partial: 'create_button', locals: { event: participant.event }, notice: 'Participant was successfully destroyed.'
  end

  private

  def participant_params
    data = params.require(:participants).permit(%i[person_id event_id])
    data.merge!({ accepted: current_person.id == data[:person_id].to_i })
  end
end
