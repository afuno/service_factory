# frozen_string_literal: true

module Usual
  class Example56Transaction
    def self.transaction(&block) # rubocop:disable Lint/UnusedMethodArgument
      yield
    end
  end

  class Example56 < ApplicationService::Base
    output :number, type: Integer

    stage do
      wrap_in ->(methods:, context:) { context.transaction! { methods.call } }

      make :assign_number_5
      make :assign_number_6
      make :assign_number_7
    end

    def assign_number_5
      outputs.number = 5
    end

    def assign_number_6
      outputs.number = 6
    end

    def assign_number_7
      outputs.number = 7
    end

    def transaction!
      Example56Transaction.transaction { yield }
    end
  end
end
