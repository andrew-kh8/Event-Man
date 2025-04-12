class PeopleController < ApplicationController
  include Authenticator

  before_action :authenticate_user
  before_action :set_person, only: %i[show edit update destroy]

  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/1
  def show
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
