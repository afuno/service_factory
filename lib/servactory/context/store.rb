# frozen_string_literal: true

module Servactory
  module Context
    class Store
      def initialize(context)
        @context = context
      end

      def fetch_internal(name)
        internals.fetch(name, nil)
      end

      def assign_internal(name, value)
        context_data[:internals].merge!({ name => value })
      end

      def fetch_output(name)
        outputs.fetch(name, nil)
      end

      def assign_output(name, value)
        context_data[:outputs].merge!({ name => value })
      end

      def outputs
        @outputs ||= context_data.fetch(:outputs)
      end

      private

      def internals
        @internals ||= context_data.fetch(:internals)
      end

      def context_data
        @context_data ||= state.fetch(context_id)
      end

      def state
        {
          context_id => {
            internals: {},
            outputs: {}
          }
        }
      end

      def context_id
        @context_id ||= "context_#{@context.object_id}"
      end
    end
  end
end
