# frozen_string_literal: true

module Wrong
  class Example11 < ApplicationService::Base
    input :ids, as: :array_of_ids, type: Array, consists_of: String

    output :first_id, type: String

    make :assign_first_id

    private

    def assign_first_id
      outputs.first_id = inputs.ids.first
    end
  end
end
