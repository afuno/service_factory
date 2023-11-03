# frozen_string_literal: true

module Servactory
  module Internals
    class Internal
      attr_reader :name,
                  :types,
                  :required

      def initialize(name, type:, **options)
        @name = name
        @types = Array(type)

        @required = options.fetch(:required, true)
      end

      def options_for_checks
        {
          types: types,
          required: required
        }
      end

      def required?
        required
      end

      def optional?
        !required
      end
    end
  end
end
