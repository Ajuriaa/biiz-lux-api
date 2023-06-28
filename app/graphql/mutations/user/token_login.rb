module Mutations
  module User
    class TokenLogin < GraphQL::Schema::Mutation
      null true
      description "Generate a user's access token."
      payload_type Types::UserType

      def resolve
        context[:current_user]
      end
    end
  end
end
