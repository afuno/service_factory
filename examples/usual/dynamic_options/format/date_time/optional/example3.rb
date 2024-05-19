# frozen_string_literal: true

module Usual
  module DynamicOptions
    module Format
      module DateTime
        module Optional
          class Example3 < ApplicationService::Base
            input :started_at, type: String, required: false

            output :started_at, type: [String, NilClass], format: :datetime

            make :assign_output

            private

            def assign_output
              outputs.started_at = inputs.started_at
            end
          end
        end
      end
    end
  end
end
