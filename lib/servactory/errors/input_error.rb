# frozen_string_literal: true

module Servactory
  module Errors
    # DEPRECATED: Use `Servactory::Exceptions::Input` instead
    class InputError < Servactory::Exceptions::Base
      attr_reader :message,
                  :input_name

      def initialize(message:, input_name: nil)
        @message = message
        @input_name = input_name&.to_sym

        super(message)
      end
    end
  end
end
