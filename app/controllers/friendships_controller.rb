class FriendshipsController < ApplicationController
  def create
    author_id = params[:author_id]
    friendship = Friendship.find_by(author_and_follower_ids(author_id))

    if friendship.nil?
      Friendship.create!(author_id: author_id, follower_id: current_person_id, not_approved_id: author_id)
      Notice::Turbo::FriendshipOffer.new.call(author_id, current_person)
    elsif friendship.not_approved_by_id?(current_person_id)
      friendship.update!(not_approved_id: nil)
    end

    render partial: 'friendship/buttons', locals: { person: Person.find(author_id) }
  end

  def destroy
    author_id = params[:id]

    friendship = Friendship.find_by!(author_and_follower_ids(author_id))

    if friendship.not_approved_id.nil?
      friendship.update!(not_approved_id: current_person_id)
    else
      friendship.destroy!
    end

    render partial: 'friendship/buttons', locals: { person: Person.find(author_id) }
  end

  private

  def current_person_id
    current_person.id
  end

  def author_and_follower_ids(author_id)
    { author_id: [current_person_id, author_id], follower_id: [current_person_id, author_id] }
  end
end
