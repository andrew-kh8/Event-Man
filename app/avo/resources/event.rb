class Avo::Resources::Event < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  self.title = :name

  def fields
    field :id, as: :id
    field :name, as: :text
    field :description, as: :textarea
    field :image, as: :text
    field :start_date, as: :date_time
    field :end_date, as: :date_time
    field :organization_id, as: :number
    field :location, as: :text
    field :online, as: :boolean
    field :organization, as: :belongs_to
    field :participants, as: :has_many
    field :people, as: :has_many, through: :participants
    field :notice_targets, as: :has_many
  end
end
