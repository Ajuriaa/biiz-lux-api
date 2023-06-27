begin
  require 'active_record'
rescue LoadError
  module ActiveRecord
    Rollback = Class.new(BizAction::Error)

    class Base
      def self.transaction(*)
        yield
      rescue Rollback
      end
    end
  end
end

module BizAction
  module Transactable
    extend ActiveSupport::Concern

    def transaction(&block)
      return unless block

      if transaction?
        ActiveRecord::Base.transaction(&block)
      else
        yield
      end
    end

    def transaction=(bool)
      @transaction = !!bool
    end

    def transaction?
      defined?(@transaction) ? @transaction : true
    end

    def transaction_options
      {}
    end
  end
end
