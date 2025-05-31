class PeopleController < ApplicationController
  include Pagy::Backend
  include Authenticator

  before_action :authenticate_user
  before_action :set_person, only: %i[edit update destroy]

  def index
    people = if params[:friends].present?
               Person.find(params[:friends]).friends
             else
               Person.all
             end

    if params[:person_name].present?
      people = people.where("concat(first_name, ' ', last_name) ILIKE ?", ['%', params[:person_name], '%'].join)
    end

    @pagy, @people = pagy(people)
  end

  def show
    @person = Person.includes(:followers_people, :following_people).find(params.expect(:id))
    part = visible_events(@person).joins(:event).order('events.start_date')

    @pagy, @participants = pagy(part, limit: 10)
  end

  def events
    @person = Person.find(params.expect(:id))

    @pagy, @events = pagy(@person.events.order(:start_date), limit: 10)
    render partial: 'events'
  end

  def edit; end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Данные профиля успешно обновлены', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy!
    redirect_to people_path, notice: 'Профиль был полностью удален', status: :see_other
  end

  private

  def set_person
    @person = Person.find(params.expect(:id))
  end

  def person_params
    params.expect(person: %i[first_name last_name avatar birthday description city])
  end

  def visible_events(person)
    return person.participants if person == current_person
    return person.participants.public_or_normal_visible if person.friend?(current_person)

    person.participants.public_visible
  end
end
