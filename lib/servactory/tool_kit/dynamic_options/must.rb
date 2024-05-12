# frozen_string_literal: true

module Servactory
  module ToolKit
    module DynamicOptions
      class Must
        class WorkOption
          attr_reader :value,
                      :message,
                      :properties

          def initialize(data, body_key:, body_fallback:)
            @value =
              if data.is_a?(Hash) && data.key?(body_key)
                data.delete(body_key)
              else
                data.present? ? data : body_fallback
              end

            @message = (data.is_a?(Hash) && data.key?(:message) ? data.delete(:message) : nil)
            @properties = data.is_a?(Hash) ? data : {}
          end
        end

        def initialize(option_name, body_key = :is, body_fallback = nil)
          @option_name = option_name
          @body_key = body_key
          @body_fallback = body_fallback
        end

        def must(name)
          Servactory::Maintenance::Attributes::OptionHelper.new(
            name: @option_name,
            equivalent: equivalent_with(name)
          )
        end

        def equivalent_with(name)
          lambda do |data|
            option = WorkOption.new(data, body_key: @body_key, body_fallback: @body_fallback)

            {
              must: {
                name => must_content_with(option)
              }
            }
          end
        end

        def must_content_with(option)
          {
            is: must_content_value_with(option),
            message: must_content_message_with(option)
          }
        end

        ########################################################################

        def must_content_value_with(option)
          lambda do |value:, input: nil, internal: nil, output: nil|
            if input.present? && input.input?
              condition_for_input_with(input:, value:, option:)
            elsif internal.present? && internal.internal?
              condition_for_internal_with(internal:, value:, option:)
            elsif output.present? && output.output?
              condition_for_output_with(output:, value:, option:)
            end
          end
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        def must_content_message_with(option)
          is_option_message_present = option.message.present?
          is_option_message_proc = option.message.is_a?(Proc) if is_option_message_present

          lambda do |input: nil, internal: nil, output: nil, **attributes|
            default_attributes = { **attributes, option_value: option.value }

            if Servactory::Utils.really_input?(input)
              if is_option_message_present
                is_option_message_proc ? option.message.call(**default_attributes.merge(input:)) : option.message
              else
                message_for_input_with(**default_attributes.merge(input:))
              end
            elsif Servactory::Utils.really_internal?(internal)
              if is_option_message_present
                is_option_message_proc ? option.message.call(**default_attributes.merge(internal:)) : option.message
              else
                message_for_internal_with(**default_attributes.merge(internal:))
              end
            elsif Servactory::Utils.really_output?(output)
              if is_option_message_present
                is_option_message_proc ? option.message.call(**default_attributes.merge(output:)) : option.message
              else
                message_for_output_with(**default_attributes.merge(output:))
              end
            end
          end
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

        ########################################################################

        def condition_for_input_with(**)
          raise "Need to implement `condition_for_input_with(**attributes)` method"
        end

        def condition_for_internal_with(**)
          raise "Need to implement `condition_for_internal_with(**attributes)` method"
        end

        def condition_for_output_with(**)
          raise "Need to implement `condition_for_output_with(**attributes)` method"
        end

        def message_for_input_with(**)
          raise "Need to implement `message_for_input_with(**attributes)` method"
        end

        def message_for_internal_with(**)
          raise "Need to implement `message_for_internal_with(**attributes)` method"
        end

        def message_for_output_with(**)
          raise "Need to implement `message_for_output_with(**attributes)` method"
        end
      end
    end
  end
end
