module Avo
  module Resources
    class Organization < Avo::BaseResource
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
        field :activity_field, as: :text
        field :logo, as: :text
        field :email, as: :text
        field :accredited, as: :boolean
        field :events, as: :has_many
        field :authored_notifications, as: :has_many
      end
    end
  end
end
