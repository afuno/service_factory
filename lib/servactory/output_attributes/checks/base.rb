# frozen_string_literal: true

module Servactory
  module OutputAttributes
    module Checks
      class Base
        protected

        def raise_error_with(message, **attributes)
          message = message.call(**attributes) if message.is_a?(Proc)

          raise Servactory.configuration.output_attribute_error_class, message
        end
      end
    end
  end
end
