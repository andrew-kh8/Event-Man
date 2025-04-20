class FriendshipsController < ApplicationController
  def create
    author_id = params[:author_id]
    @friendship = Friendship.find_by(author_id: [current_person.id, author_id],
                                     follower_id: [current_person.id, author_id])

    if @friendship.nil?
      Friendship.create!(author_id: author_id, follower_id: current_person.id, not_approved_id: author_id)
      text = 'Запрос на дружбу отправлен'
      n = Notification.create(author: current_person, person_id: author_id, notice_type: 'offer', text:, target_type: 'Person',
                              target_id: current_person.id)
      Turbo::StreamsChannel.broadcast_prepend_to "notifications_for_#{author_id}",
                                                 partial: 'layouts/notification',
                                                 locals: { nid: n.id,
                                                           notification_text: "Новый запрос на дружбу от #{current_person.full_name}" },
                                                 target: "notification_#{author_id}"
      return redirect_to person_path(author_id), notice: text, status: :ok
    end

    if @friendship.not_approved_id.nil? || @friendship.not_approved_id == author_id
      return redirect_to person_path(author_id), notice: 'Запрос на дружбу уже отправлен', status: :ok
    end

    if @friendship.not_approved_id == current_person.id
      @friendship.update!(not_approved_id: nil)
      return redirect_to person_path(author_id), notice: 'Запрос на дружбу принят', status: :ok
    end

    redirect_to person_path(author_id), alert: 'Что-то пошло не так', status: :internal_server_error
  end

  def destroy
    author_id = params[:id]

    @friendship = Friendship.find_by!(author_id: [current_person.id, author_id],
                                      follower_id: [current_person.id, author_id])

    if @friendship.not_approved_id.nil?
      @friendship.update!(not_approved_id: current_person.id)
    else
      @friendship.destroy!
    end

    redirect_to person_path(author_id), notice: 'Запрос на дружбу отклонен', status: :ok
  end
end
