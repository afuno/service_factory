# frozen_string_literal: true

require_relative "extensions/status_active/dsl"

module ApplicationService
  class Base
    include Servactory::DSL.with_extensions(
      ApplicationService::Extensions::StatusActive::DSL
    )

    configuration do
      input_exception_class ApplicationService::Exceptions::Input
      internal_exception_class ApplicationService::Exceptions::Internal
      output_exception_class ApplicationService::Exceptions::Output

      # DEPRECATED: These configs will be deleted after release 2.4.
      # input_error_class ApplicationService::Errors::InputError
      # internal_error_class ApplicationService::Errors::InternalError
      # output_error_class ApplicationService::Errors::OutputError

      failure_class ApplicationService::Exceptions::Failure

      input_option_helpers(
        [
          Servactory::Maintenance::Attributes::OptionHelper.new(
            name: :must_be_6_characters,
            equivalent: {
              must: {
                be_6_characters: {
                  is: ->(value:) { value.all? { |id| id.size == 6 } },
                  message: lambda do |input:, **|
                    "Wrong IDs in `#{input.name}`"
                  end
                }
              }
            }
          ),
          Servactory::ToolKit::DynamicOptions::Min.setup,
          Servactory::ToolKit::DynamicOptions::Max.setup
        ]
      )

      internal_option_helpers(
        [
          Servactory::ToolKit::DynamicOptions::Min.setup,
          Servactory::ToolKit::DynamicOptions::Max.setup
        ]
      )

      output_option_helpers(
        [
          Servactory::ToolKit::DynamicOptions::Min.setup,
          Servactory::ToolKit::DynamicOptions::Max.setup
        ]
      )

      action_shortcuts %i[assign]
      action_aliases %i[play do_it!]
    end
  end
end
