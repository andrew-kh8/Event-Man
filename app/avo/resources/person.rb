module Avo
  module Resources
    class Person < Avo::BaseResource
      # self.includes = []
      # self.single_attachments = [:avatar]
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }
      self.title = :first_name

      def fields
        field :id, as: :id
        field :first_name, as: :text
        field :last_name, as: :text
        field :avatar, as: :text
        field :birthday, as: :date
        field :description, as: :textarea
        field :city, as: :text
        field :email, as: :text
        field :followers, as: :has_many
        field :followers_people, as: :has_many, through: :followers
        field :following, as: :has_many
        field :following_people, as: :has_many, through: :following
        field :participants, as: :has_many
        field :events, as: :has_many, through: :participants
        field :notifications, as: :has_many
        field :authored_notifications, as: :has_many
        field :notice_targets, as: :has_many
      end
    end
  end
end
