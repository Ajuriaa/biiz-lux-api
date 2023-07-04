module BiizAction
  module DelegatesToParams
    extend ActiveSupport::Concern

    module ClassMethods
      delegate :reflect_on_association, to: :params_class

      def sss?(sym, include_private: false)
        pass_to_params_class?(sym) || super(sym, include_private)
      end

      def method_missing(sym, *args, &)
        if pass_to_params_class?(sym)
          params_class.send(sym, *args, &)
        else
          super(sym, *args, &)
        end
      end

      def pass_to_params_class?(sym)
        params_class.respond_to?(sym)
      end
    end

    def respond_to?(sym, include_private: false)
      params.respond_to?(sym) || super(sym, include_private)
    end

    def method_missing(sym, *args, &)
      if params.respond_to?(sym)
        params.send(sym, *args, &)
      else
        super(sym, *args, &)
      end
    end
  end
end
