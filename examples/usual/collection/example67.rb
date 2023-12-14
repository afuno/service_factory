# frozen_string_literal: true

module Usual
  module Collection
    class Example67 < ApplicationService::Base
      input :ids,
            type: Set,
            consists_of: {
              type: String,
              message: lambda do |input_name:, expected_type:, **|
                "Input `#{input_name}` must be a collection of `#{expected_type}`"
              end
            }

      output :first_id, type: String

      make :assign_first_id

      private

      def assign_first_id
        outputs.first_id = inputs.ids.first
      end
    end
  end
end
