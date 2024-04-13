# frozen_string_literal: true

RSpec.describe Usual::Basic::Example12, type: :service do
  describe ".call!" do
    subject(:perform) { described_class.call!(**attributes) }

    let(:attributes) do
      {
        first_name: first_name,
        middle_name: middle_name,
        last_name: last_name,
        gender: gender
      }
    end

    let(:first_name) { "John" }
    let(:middle_name) { "Fitzgerald" }
    let(:last_name) { "Kennedy" }
    let(:gender) { "Male" }

    include_examples "check class info",
                     inputs: %i[first_name middle_name last_name gender],
                     internals: %i[first_name middle_name last_name gender],
                     outputs: %i[full_name]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        include_examples "success result class"

        it { expect(perform).to have_output(:full_name).with("JOHN FITZGERALD KENNEDY") }
      end
    end

    context "when the input arguments are invalid" do
      it { expect { perform }.to have_input(:first_name).direct(attributes).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:middle_name).direct(attributes).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:last_name).direct(attributes).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:gender).direct(attributes).type(String).required }
    end
  end

  describe ".call" do
    subject(:perform) { described_class.call(**attributes) }

    let(:attributes) do
      {
        first_name: first_name,
        middle_name: middle_name,
        last_name: last_name,
        gender: gender
      }
    end

    let(:first_name) { "John" }
    let(:middle_name) { "Fitzgerald" }
    let(:last_name) { "Kennedy" }
    let(:gender) { "Male" }

    include_examples "check class info",
                     inputs: %i[first_name middle_name last_name gender],
                     internals: %i[first_name middle_name last_name gender],
                     outputs: %i[full_name]

    context "when the input arguments are valid" do
      describe "and the data required for work is also valid" do
        include_examples "success result class"

        it { expect(perform).to have_output(:full_name).with("JOHN FITZGERALD KENNEDY") }
      end
    end

    context "when the input arguments are invalid" do
      it { expect { perform }.to have_input(:first_name).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:middle_name).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:last_name).direct(attributes).type(String).required }
      it { expect { perform }.to have_input(:gender).direct(attributes).type(String).required }
    end
  end
end
