module ConnectionHelpers
  def self.define_connection(type_class)
    connection_type = GraphQL::Relay::ConnectionType.define do
      name("#{type_class.name}Connection")
      node_type(type_class)
    end

    field_name = type_class.name.underscore.pluralize.to_sym
    field field_name, [type_class], null: false do
      argument :after, String, required: false
      argument :before, String, required: false
      argument :first, Integer, required: false
      argument :last, Integer, required: false
    end

    define_method(field_name) do |**args|
      records = yield
      records = apply_pagination(records, args)

      connection_class = connection_type.connection_for_nodes(records)
      connection_class.new(records, args)
    end
  end

  private

  def apply_pagination(records, args)
    records = records.limit(args[:first]) if args[:first]

    records = records.last(args[:last]) if args[:last]

    records
  end
end
