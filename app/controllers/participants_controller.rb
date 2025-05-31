class ParticipantsController < ApplicationController
  # POST /participants
  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      if accepted?
        notification_text = "Вы записаны на мероприятие #{@participant.event.name}"
        Notification.create(person: current_person,
                            author: current_person,
                            target: @participant.event,
                            notice_type: 'info',
                            text: notification_text)
      else
        notification_text = "Вы приглашены на мероприятие #{@participant.event.name}"
        Notification.create(person_id: params[:participants][:person_id],
                            author: current_person,
                            target: @participant.event,
                            notice_type: 'invite', text: notification_text)
      end

      Turbo::StreamsChannel.broadcast_prepend_to "notifications_for_#{@participant.person_id}",
                                                 partial: 'layouts/notification',
                                                 locals: { nid: @participant.id, notification_text: },
                                                 target: "notification_#{@participant.person_id}"

      return render partial: 'destroy_button', locals: { participant: @participant },
                    notice: 'Participant was successfully created.'
    end

    render partial: 'create_button', locals: { event: @participant.event }, notice: 'ERROR'
  end

  # PUT /participants/1
  def update
    participant = Participant.find(params[:id])
    participant.update!(participant_params)

    if params[:participants][:visible]
      render partial: "people/profile/visible_icons/#{participant.visible}_visible_icon", locals: { participant: }
    else
      render partial: 'destroy_button', locals: { participant: }, notice: 'Participant was successfully created.'
    end
  end

  # DELETE /participants/1
  def destroy
    participant = Participant.find(params[:id])
    participant.destroy!

    render partial: 'create_button',
           locals: { event: participant.event },
           notice: 'Participant was successfully destroyed.'
  end

  private

  def participant_params
    params[:participants][:accepted] = accepted?
    params.require(:participants).permit(%i[person_id event_id visible accepted])
  end

  def accepted?
    params[:participants][:person_id].nil? || current_person.id == params[:participants][:person_id].to_i
  end
end
