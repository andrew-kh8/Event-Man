# frozen_string_literal: true

module Notice
  module Turbo
    class FriendshipOffer
      TEXT = 'Запрос на дружбу отправлен'

      def call(author_id, person)
        n = Notification.create(author: person,
                                person_id: author_id,
                                notice_type: Notification.notice_types[:offer],
                                text: TEXT,
                                target: person)
        ::Turbo::StreamsChannel.broadcast_prepend_to(
          "notifications_for_#{author_id}",
          partial: 'layouts/notification',
          locals: { nid: n.id,
                    notification_text: "Новый запрос на дружбу от #{person.full_name}" },
          target: "notification_#{author_id}"
        )
      end
    end
  end
end
