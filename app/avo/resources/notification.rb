module Avo
  module Resources
    class Notification < Avo::BaseResource
      # self.includes = []
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :person_id, as: :number
        field :text, as: :text
        field :read, as: :boolean
        field :author_type, as: :text
        field :author_id, as: :number
        field :target_type, as: :text
        field :target_id, as: :number
        field :notice_type, as: :text
        field :person, as: :belongs_to
        field :author, as: :belongs_to, polymorphic_as: :author, types: [Person, Organization]
        field :target, as: :belongs_to, polymorphic_as: :target, types: [Person, Event]
      end
    end
  end
end
