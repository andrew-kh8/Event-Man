class PeopleController < ApplicationController
  include Pagy::Backend
  include Authenticator

  before_action :authenticate_user
  before_action :set_person, only: %i[show edit update destroy]

  # GET /people
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

  # GET /people/1
  def show
    @person = Person.includes(:followers, :following).find(params.expect(:id))
  end

  # GET /people/1/edit
  def edit
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy!
    redirect_to people_path, notice: 'Person was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.expect(person: %i[first_name last_name avatar birthday description city])
  end
end
