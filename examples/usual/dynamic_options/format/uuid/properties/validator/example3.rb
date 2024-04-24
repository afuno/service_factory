# frozen_string_literal: true

module Usual
  module DynamicOptions
    module Format
      module Uuid
        module Properties
          module Validator
            class Example3 < ApplicationService::Base
              input :uuid, type: String

              output :uuid,
                     type: String,
                     format: {
                       is: :uuid,
                       pattern: nil, # This will disable the value checking based on the pattern
                       validator: lambda do |value:|
                         value.size >= 9
                       end
                     }

              make :assign_output

              private

              def assign_output
                outputs.uuid = inputs.uuid
              end
            end
          end
        end
      end
    end
  end
end
