# frozen_string_literal: true

module Servactory
  module Outputs
    class Output
      class Work
        attr_reader :name,
                    :types,
                    :inclusion

        def initialize(output)
          @name = output.name
          @types = output.types
          @inclusion = output.inclusion.slice(:in) if output.inclusion_present?

          define_singleton_method(:system_name) { output.system_name }
          define_singleton_method(:i18n_name) { output.i18n_name }
          # The methods below are required to support the internal work.
          define_singleton_method(:input?) { false }
          define_singleton_method(:internal?) { false }
          define_singleton_method(:output?) { true }
        end
      end

      attr_reader :name,
                  :collection_of_options

      def initialize(
        name,
        *helpers,
        hash_mode_class_names:,
        option_helpers:,
        **options
      )
        @name = name
        @hash_mode_class_names = hash_mode_class_names
        @option_helpers = option_helpers

        register_options(helpers: helpers, options: options)
      end

      def method_missing(name, *args, &block)
        option = @collection_of_options.find_by(name: name)

        return super if option.nil?

        option.body
      end

      def respond_to_missing?(name, *)
        @collection_of_options.names.include?(name) || super
      end

      def register_options(helpers:, options:) # rubocop:disable Metrics/MethodLength
        advanced_helpers = options.except(*Servactory::Maintenance::Attributes::Options::Registrar::RESERVED_OPTIONS)

        options = apply_helpers_for_options(helpers: helpers, options: options) if helpers.present?
        options = apply_helpers_for_options(helpers: advanced_helpers, options: options) if advanced_helpers.present?

        options_registrar = Servactory::Maintenance::Attributes::Options::Registrar.register(
          attribute: self,
          hash_mode_class_names: @hash_mode_class_names,
          options: options,
          features: {
            types: true,
            hash: true,
            inclusion: true,
            must: true
          }
        )

        @collection_of_options = options_registrar.collection
      end

      def apply_helpers_for_options(helpers:, options:) # rubocop:disable Metrics/MethodLength
        prepared_options = {}

        helpers.each do |(helper, values)|
          found_helper = @option_helpers.find_by(name: helper)

          next if found_helper.blank?

          prepared_option =
            if found_helper.equivalent.is_a?(Proc)
              values.is_a?(Hash) ? found_helper.equivalent.call(**values) : found_helper.equivalent.call(values)
            else
              found_helper.equivalent
            end

          prepared_options.deep_merge!(prepared_option)
        end

        options.merge(prepared_options)
      end

      def options_for_checks
        @collection_of_options.options_for_checks
      end

      def system_name
        self.class.name.demodulize.downcase.to_sym
      end

      def i18n_name
        system_name.to_s.pluralize
      end

      def input?
        false
      end

      def internal?
        false
      end

      def output?
        true
      end
    end
  end
end
