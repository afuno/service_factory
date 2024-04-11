# frozen_string_literal: true

RSpec.describe Wrong::Basic::Example4, type: :service do
  describe ".call!" do
    subject(:perform) { described_class.call!(**attributes) }

    let(:attributes) do
      {
        invoice_number: invoice_number
      }
    end

    let(:invoice_number) { "ABC-123" }

    include_examples "check class info",
                     inputs: %i[invoice_number],
                     internals: %i[prepared_invoice_number],
                     outputs: %i[invoice_number]

    context "when the input arguments are valid" do
      describe "but the data required for work is invalid" do
        it "returns expected error" do
          expect { perform }.to(
            raise_error(
              ApplicationService::Exceptions::Output,
              "[Wrong::Basic::Example4] Undefined output attribute `number`"
            )
          )
        end
      end
    end

    context "when the input arguments are invalid" do
      it "returns expected inputs", :aggregate_failures do
        expect { perform }.to have_service_input(:invoice_number).type(String).required
      end
    end
  end

  describe ".call" do
    subject(:perform) { described_class.call(**attributes) }

    let(:attributes) do
      {
        invoice_number: invoice_number
      }
    end

    let(:invoice_number) { "ABC-123" }

    include_examples "check class info",
                     inputs: %i[invoice_number],
                     internals: %i[prepared_invoice_number],
                     outputs: %i[invoice_number]

    context "when the input arguments are valid" do
      describe "but the data required for work is invalid" do
        it "returns expected error" do
          expect { perform }.to(
            raise_error(
              ApplicationService::Exceptions::Output,
              "[Wrong::Basic::Example4] Undefined output attribute `number`"
            )
          )
        end
      end
    end

    context "when the input arguments are invalid" do
      it "returns expected inputs", :aggregate_failures do
        expect { perform }.to have_service_input(:invoice_number).type(String).required
      end
    end
  end
end
