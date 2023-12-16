# frozen_string_literal: true

module Wrong
  class Example4 < ApplicationService::Base
    input :invoice_number, type: String

    internal :prepared_invoice_number, type: String

    output :invoice_number, type: String

    make :prepare_invoice_number
    make :assign_invoice_number

    private

    def prepare_invoice_number
      internals.prepared_invoice_number = inputs.invoice_number
    end

    def assign_invoice_number
      outputs.number = internals.prepared_invoice_number
    end
  end
end
