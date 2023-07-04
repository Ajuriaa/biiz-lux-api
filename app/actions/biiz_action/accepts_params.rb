module BiizAction
  module AcceptsParams
    extend ActiveSupport::Concern

    attr_accessor :params_class

    def params(&)
      klass_name = model_name.to_s
      klass_name = get_non_namespaced_module(klass_name)
      klass_name += 'Params'
      @params_class = Class.new(BiizAction::Params).tap do |klass|
        extend ActiveModel::Naming
        klass.with_rails_helpers
        const_set(klass_name, klass)
        klass.class_eval(&)
      end
    end

    private

    def get_non_namespaced_module(name)
      name.split('::').last || name
    end
  end
end
