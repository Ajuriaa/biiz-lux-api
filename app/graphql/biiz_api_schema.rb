require_relative 'connection_helpers'

class BiizApiSchema < GraphQL::Schema
  # Include connections for pagination
  include ConnectionHelpers

  mutation(Types::MutationType)
  query(Types::QueryType)
end
