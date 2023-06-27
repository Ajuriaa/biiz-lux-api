module BizAction
  class ValidationBuilder
    def initialize(opts = {})
      @opts = opts
      @validations = opts[:validations] || {}
    end

    def build
      if allow_nil?
        @validations[:allow_nil] = true unless @validations.empty?
      else
        @validations[:presence] = true
      end

      @validations
    end

    private

    def default?
      @opts.key?(:default)
    end
    alias has_default? default?

    def optional?
      !!@opts[:optional]
    end

    def allow_nil?
      optional? || has_default?
    end
  end
end
