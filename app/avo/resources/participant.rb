class Avo::Resources::Participant < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :person_id, as: :number
    field :event_id, as: :number
    field :visible, as: :select, enum: ::Participant.visibles
    field :accepted, as: :boolean
    field :person, as: :belongs_to
    field :event, as: :belongs_to
  end
end
