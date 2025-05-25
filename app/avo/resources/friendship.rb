module Avo
  module Resources
    class Friendship < Avo::BaseResource
      # self.includes = []
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :author_id, as: :number
        field :follower_id, as: :number
        field :not_approved_id, as: :number
        field :author, as: :belongs_to
        field :follower, as: :belongs_to
        field :not_approved, as: :belongs_to
      end
    end
  end
end
