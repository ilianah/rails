# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    module MySQL
      class TypeMetadata < ActiveSupport::Delegation::DelegateClass(SqlTypeMetadata) # :nodoc:
        undef to_yaml if method_defined?(:to_yaml)

        include Deduplicable

        attr_reader :extra

        def initialize(type_metadata, extra: nil)
          super(type_metadata)
          @extra = extra.presence
        end

        def as_schema_json
          { "type_metadata" => __getobj__, "extra" => extra }
        end

        def init_from_schema_json(coder)
          __setobj__(coder["type_metadata"])
          @extra = coder["extra"]
        end

        def ==(other)
          other.is_a?(TypeMetadata) &&
            __getobj__ == other.__getobj__ &&
            extra == other.extra
        end
        alias eql? ==

        def hash
          [
            TypeMetadata,
            __getobj__,
            @extra,
          ].hash
        end

        private
          def deduplicated
            __setobj__(__getobj__.deduplicate)
            @extra = -extra if extra
            super
          end

      end
    end
  end
end
