module Avo
  module Resources
    class StarredOrganization < Avo::BaseResource
      # self.includes = []
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :person, as: :text
        field :organization, as: :text
      end
    end
  end
end
