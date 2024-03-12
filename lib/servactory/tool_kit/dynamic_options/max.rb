# frozen_string_literal: true

module Servactory
  module ToolKit
    module DynamicOptions
      class Max < Must
        def self.setup(option_name = :max)
          new(option_name).must(:be_less_than_or_equal_to)
        end

        def condition_for_input_with(...)
          common_condition_with(...)
        end

        def condition_for_internal_with(...)
          common_condition_with(...)
        end

        def condition_for_output_with(...)
          common_condition_with(...)
        end

        def common_condition_with(value:, option_value:, **)
          case value
          when Integer
            value <= option_value
          else
            return false unless value.respond_to?(:size)

            value.size <= option_value
          end
        end

        ########################################################################

        def message_for_input_with(service_class_name:, input:, value:, option_value:, **)
          I18n.t(
            "servactory.inputs.validations.must.dynamic_options.max.default",
            service_class_name: service_class_name,
            input_name: input.name,
            value: value,
            option_value: option_value
          )
        end

        def message_for_internal_with(service_class_name:, internal:, value:, option_value:, **)
          I18n.t(
            "servactory.internals.validations.must.dynamic_options.max.default",
            service_class_name: service_class_name,
            internal_name: internal.name,
            value: value,
            option_value: option_value
          )
        end

        def message_for_output_with(service_class_name:, output:, value:, option_value:, **)
          I18n.t(
            "servactory.outputs.validations.must.dynamic_options.max.default",
            service_class_name: service_class_name,
            output_name: output.name,
            value: value,
            option_value: option_value
          )
        end
      end
    end
  end
end
