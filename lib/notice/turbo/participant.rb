# frozen_string_literal: true

module Notice
  module Turbo
    class Participant
      REGISTERED = 'записаны'
      INVITED = 'приглашены'

      def call(author, participant)
        Notification.create!(
          author:,
          person: participant.person,
          target: participant.event,
          notice_type: participant.accepted? ? ::Notification::INFO : ::Notification::INVITE,
          text: notification_text(participant)
        )

        ::Turbo::StreamsChannel.broadcast_prepend_to(
          "notifications_for_#{participant.person_id}",
          partial: 'layouts/notification',
          locals: { nid: participant.id, notification_text: notification_text(participant) },
          target: "notification_#{participant.person_id}"
        )
      end

      private

      def notification_text(participant)
        action = participant.accepted? ? REGISTERED : INVITED

        "Вы #{action} на мероприятие #{participant.event.name}"
      end
    end
  end
end
