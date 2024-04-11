# frozen_string_literal: true

RSpec.describe Usual::DynamicOptions::Format::Boolean::Is::Example1, type: :service do
  describe ".call!" do
    subject(:perform) { described_class.call!(**attributes) }

    let(:attributes) do
      {
        boolean: boolean
      }
    end

    let(:boolean) { "true" }

    include_examples "check class info",
                     inputs: %i[boolean],
                     internals: %i[],
                     outputs: %i[boolean]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        it "returns the expected value", :aggregate_failures do
          result = perform

          expect(result.boolean?).to be(true)
          expect(result.boolean).to eq("true")
        end
      end

      describe "but the data required for work is invalid" do
        describe "because the format is not suitable for `boolean`" do
          let(:boolean) { "off" }

          it "returns expected error" do
            expect { perform }.to(
              raise_error(
                ApplicationService::Exceptions::Input,
                "[Usual::DynamicOptions::Format::Boolean::Is::Example1] " \
                "Input `boolean` does not match `boolean` format"
              )
            )
          end
        end
      end
    end

    context "when the input arguments are invalid" do
      it { expect(perform).to have_service_input(:boolean).type(String).required }
    end
  end

  describe ".call" do
    subject(:perform) { described_class.call(**attributes) }

    let(:attributes) do
      {
        boolean: boolean
      }
    end

    let(:boolean) { "true" }

    include_examples "check class info",
                     inputs: %i[boolean],
                     internals: %i[],
                     outputs: %i[boolean]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        it "returns the expected value", :aggregate_failures do
          result = perform

          expect(result.boolean?).to be(true)
          expect(result.boolean).to eq("true")
        end
      end

      describe "but the data required for work is invalid" do
        describe "because the format is not suitable for `boolean`" do
          let(:boolean) { "off" }

          it "returns expected error" do
            expect { perform }.to(
              raise_error(
                ApplicationService::Exceptions::Input,
                "[Usual::DynamicOptions::Format::Boolean::Is::Example1] " \
                "Input `boolean` does not match `boolean` format"
              )
            )
          end
        end
      end
    end

    context "when the input arguments are invalid" do
      it { expect(perform).to have_service_input(:boolean).type(String).required }
    end
  end
end
