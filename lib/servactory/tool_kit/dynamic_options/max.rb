# frozen_string_literal: true

module Servactory
  module ToolKit
    module DynamicOptions
      class Max < Base
        def self.setup
          new(:max).setup(:be_less_than_or_equal_to)
        end

        def condition_for_input_with(value:, received_value:, **)
          case value.class
          when Integer
            value <= received_value
          when String, Array
            value.size <= received_value
          else
            false
          end
        end

        def condition_for_internal_with(value:, received_value:, **)
          case value.class
          when Integer
            value <= received_value
          when String, Array
            value.size <= received_value
          else
            false
          end
        end

        def condition_for_output_with(value:, received_value:, **)
          case value.class
          when Integer
            value <= received_value
          when String, Array
            value.size <= received_value
          else
            false
          end
        end

        ########################################################################

        def message_for_input_with(service_class_name:, input_name:, value:, received_value:, **)
          "[#{service_class_name}] Input attribute `#{input_name}` " \
            "received value `#{value}`, which is greater than `#{received_value}`"
        end

        def message_for_internal_with(service_class_name:, input_name:, value:, received_value:, **)
          "[#{service_class_name}] Internal attribute `#{input_name}` " \
            "received value `#{value}`, which is greater than `#{received_value}`"
        end

        def message_for_output_with(service_class_name:, input_name:, value:, received_value:, **)
          "[#{service_class_name}] Output attribute `#{input_name}` " \
            "received value `#{value}`, which is greater than `#{received_value}`"
        end
      end
    end
  end
end
