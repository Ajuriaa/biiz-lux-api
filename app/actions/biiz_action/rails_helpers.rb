module BiizAction
  module RailsHelpers
    extend ActiveSupport::Concern
    included do
      def to_model
        self
      end

      def name_came_from_user?; end

      def _destroy_came_from_user?; end

      # Required for ActiveModel
      def persisted?
        false
      end

      def each
        self
      end

      def marked_for_destruction?
        _destroy.eql?(true)
      end
    end

    module ClassMethods
      attr_accessor :rails_helpers

      def with_rails_helpers
        @rails_helpers = true
      end

      def using_rails_helpers?
        @rails_helpers ||= false
        !!@rails_helpers
      end

      def reflect_on_association(assoc_sym)
        nested_classes[assoc_sym]
      end

      def klass
        self
      end

      def define_rails_helpers(name, klass)
        define_method("#{name}_attributes=") do |value|
          send("#{name}=", value)
        end

        singular_key = singularized_key(name)
        define_method("build_#{singular_key}") do |value = {}|
          klass.new(value, self)
        end
      end

      private

      def singularized_key(key)
        key.to_s.singularize
      end
    end
  end
end
