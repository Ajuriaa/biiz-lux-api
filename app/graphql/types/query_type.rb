module Types
  class QueryType < Types::BaseObject
    # Profile
    field :current_user, resolver: Resolvers::CurrentUser
  end
end
