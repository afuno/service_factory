# frozen_string_literal: true

module Usual
  class Example11 < ApplicationService::Base
    input :ids, type: Array, consists_of: { type: String }

    internal :ids, type: Array, consists_of: { type: String }

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
