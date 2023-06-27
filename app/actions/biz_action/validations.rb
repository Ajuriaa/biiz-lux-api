module BizAction
  module Validations
    extend ActiveModel::Validations

    def valid?(context = nil)
      current_context = validation_context
      self.validation_context = context
      errors.clear
      run_validations!

      # Make sure that nested classes are also valid
      errors.empty?
    ensure
      self.validation_context = current_context
    end

    def validate!
      raise BizParamsError, errors.to_hash.to_s unless valid?
    end
  end
end
