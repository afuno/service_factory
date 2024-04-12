# frozen_string_literal: true

RSpec.describe Usual::DynamicOptions::Format::Email::Properties::Validator::Example1, type: :service do
  describe ".call!" do
    subject(:perform) { described_class.call!(**attributes) }

    let(:attributes) do
      {
        email: email
      }
    end

    let(:email) { "noreply at servactory.com" }

    include_examples "check class info",
                     inputs: %i[email],
                     internals: %i[],
                     outputs: %i[email]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        it "returns the expected value", :aggregate_failures do
          result = perform

          expect(result.email?).to be(true)
          expect(result.email).to eq("No Reply <noreply at servactory.com>")
        end
      end

      describe "but the data required for work is invalid" do
        describe "because the format is not suitable for `email`" do
          let(:email) { "noreply@servactory.com" }

          it "returns expected error" do
            expect { perform }.to(
              raise_error(
                ApplicationService::Exceptions::Input,
                "[Usual::DynamicOptions::Format::Email::Properties::Validator::Example1] " \
                "Input `email` does not match `email` format"
              )
            )
          end
        end
      end
    end

    context "when the input arguments are invalid" do
      it { expect(perform).to have_input(:email).type(String).required }
    end
  end

  describe ".call" do
    subject(:perform) { described_class.call(**attributes) }

    let(:attributes) do
      {
        email: email
      }
    end

    let(:email) { "noreply at servactory.com" }

    include_examples "check class info",
                     inputs: %i[email],
                     internals: %i[],
                     outputs: %i[email]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        it "returns the expected value", :aggregate_failures do
          result = perform

          expect(result.email?).to be(true)
          expect(result.email).to eq("No Reply <noreply at servactory.com>")
        end
      end

      describe "but the data required for work is invalid" do
        describe "because the format is not suitable for `email`" do
          let(:email) { "noreply@servactory.com" }

          it "returns expected error" do
            expect { perform }.to(
              raise_error(
                ApplicationService::Exceptions::Input,
                "[Usual::DynamicOptions::Format::Email::Properties::Validator::Example1] " \
                "Input `email` does not match `email` format"
              )
            )
          end
        end
      end
    end

    context "when the input arguments are invalid" do
      it { expect(perform).to have_input(:email).type(String).required }
    end
  end
end
