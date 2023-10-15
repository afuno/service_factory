# frozen_string_literal: true

module Servactory
  module Internals
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def inherited(child)
          super

          child.send(:collection_of_internals).merge(collection_of_internals)
        end

        private

        def internal(name, **options)
          collection_of_internals << Internal.new(
            name,
            collection_mode_class_names: config.collection_mode_class_names,
            object_mode_class_names: config.object_mode_class_names,
            **options
          )
        end

        def collection_of_internals
          @collection_of_internals ||= Collection.new
        end
      end
    end
  end
end
