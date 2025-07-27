class ParticipantsController < ApplicationController
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      Notice::Turbo::Participant.new.call(current_person, @participant)

      render partial: 'destroy_button', locals: { participant: @participant }
    else
      render partial: 'create_button', locals: { event: @participant.event }, notice: 'Произошла ошибка'
    end
  end

  def update
    participant = Participant.find(params[:id])
    participant.update!(participant_params)

    if params[:participants][:visible]
      render partial: "people/profile/visible_icons/#{participant.visible}_visible_icon", locals: { participant: }
    else
      render partial: 'destroy_button', locals: { participant: }, notice: 'Участие в мероприятии подтверждено'
    end
  end

  def destroy
    participant = Participant.find(params[:id]) # error when try to change visibility of cancelled participation
    participant.destroy!

    render partial: 'create_button',
           locals: { event: participant.event },
           notice: 'Участие в мероприятии отменено'
  end

  private

  def participant_params
    params[:participants][:accepted] = current_person.id == params[:participants][:person_id].to_i
    params.require(:participants).permit(%i[person_id event_id visible accepted]) # are [person_id, event_id] needed?
  end
end
