# frozen_string_literal: true

module Wrong
  class Example9 < ApplicationService::Base
    input :invoice_number, type: String

    output :prepared_invoice_number, type: String

    make :prepare_invoice_number

    private

    def prepare_invoice_number
      outputs.prepared_invoice_number = inputs.invoice_number.split("-").last
    end
  end
end
