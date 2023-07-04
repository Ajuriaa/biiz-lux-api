module BiizAction
  class Params
    extend ActiveModel::Naming
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include Validations
    include RailsHelpers

    with_rails_helpers

    class << self
      def param(name, opts = {})
        define_attribute(name, opts)
        add_validations(name, opts)
      end

      def defined_attributes
        @_defined_attributes ||= {}
      end

      private

      def define_attribute(name, opts = {})
        attr_accessor "#{name}_attribute"

        defined_attributes[name.to_sym] = opts

        define_method(name.to_s) do
          attribute = send("#{name}_attribute")
          attribute.send(:value)
        end

        define_method("#{name}=") do |val|
          attribute = send("#{name}_attribute")
          attribute.send(:value=, val)
        end
      end

      def add_validations(name, opts = {})
        validations = BiizAction::ValidationBuilder.new(opts).build
        validates name, validations unless validations.empty?
      end
    end

    def initialize(params = {})
      @original_params = params
      define_attributes(@original_params)
      set_accessors(params)
    end

    def define_attributes(_params)
      self.class.defined_attributes.each_pair do |key, opts|
        send("#{key}_attribute=", Attribute.new(key, opts))
      end
    end

    def errors
      @_errors ||= BiizAction::Errors.new(self)
    end

    # Old custom methods

    def add_error_and_roll_back(error_key, error_message)
      errors.add(error_key, error_message)
      roll_back
    end

    def add_errors_and_roll_back(error_hash)
      add_errors error_hash
      roll_back
    end

    def add_errors(error_hash)
      error_hash.each { |error_key, error_message| errors.add(error_key, error_message) }
    end

    def roll_back
      raise ActiveRecord::Rollback
    end

    def param?(key)
      @original_params.key?(key)
    end

    private

    def set_accessors(params = {})
      params.each do |attribute_name, value|
        send("#{attribute_name}=", value)
      end
    end

    def defined_attributes
      self.class.defined_attributes
    end
  end
end
