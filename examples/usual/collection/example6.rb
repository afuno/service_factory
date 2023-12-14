# frozen_string_literal: true

module Usual
  module Collection
    class Example6 < ApplicationService::Base
      input :ids, type: Array, consists_of: String

      internal :ids, type: Array, consists_of: String

      output :first_id, type: String

      make :assign_internal
      make :assign_first_id

      private

      def assign_internal
        internals.ids = inputs.ids
      end

      def assign_first_id
        outputs.first_id = internals.ids.first
      end
    end
  end
end
