# frozen_string_literal: true

require "json"

module ActiveRecord
  module ConnectionAdapters
    class JSONSchemaCacheSerializer
      @class_registry = {} # type to  class {"col" -> Column}
      @type_registry = {} # class to type {Column -> "column"}

      loading_proc = ->(object) do
        if object.is_a?(Hash) && object.key?("_type")
          klass = class_for(object["_type"])
          instance = klass.allocate
          instance.init_from_schema_json(object)
          instance
        else
          object
        end
      end

      CODER = JSON::Coder.new(indent: "  ", space: " ", object_nl: "\n", array_nl: "\n", on_load: loading_proc) do |object, is_key|
        data = object.as_schema_json
        data.compact!
        data["_type"] = type_for(object.class)
        data
      end

      class << self
        def register(type, klass)
          @class_registry[type] = klass
          @type_registry[klass] = type
        end

        def class_for(type)
          @class_registry.fetch(type)
        end

        def type_for(klass)
          @type_registry.fetch(klass)
        end

        def dump(cache)
          CODER.dump(cache)
        end

        def load(data)
          CODER.load(data)
        end
      end
    end

    JSONSchemaCacheSerializer.register "date", Type::Date
    JSONSchemaCacheSerializer.register "datetime", Type::DateTime
    JSONSchemaCacheSerializer.register "decimal_without_scale", Type::DecimalWithoutScale
    JSONSchemaCacheSerializer.register "json", Type::Json
    JSONSchemaCacheSerializer.register "text", Type::Text
    JSONSchemaCacheSerializer.register "time", Type::Time
    JSONSchemaCacheSerializer.register "unsigned_integer", Type::UnsignedInteger

    JSONSchemaCacheSerializer.register "column", Column
    JSONSchemaCacheSerializer.register "index", IndexDefinition
    JSONSchemaCacheSerializer.register "schema_cache", SchemaCache
    JSONSchemaCacheSerializer.register "sql_type_metadata", SqlTypeMetadata
    JSONSchemaCacheSerializer.register "bigdecimal", BigDecimal


    JSONSchemaCacheSerializer.register "binary", ActiveModel::Type::Binary
    JSONSchemaCacheSerializer.register "boolean", ActiveModel::Type::Boolean
    JSONSchemaCacheSerializer.register "float", ActiveModel::Type::Float
    JSONSchemaCacheSerializer.register "decimal", ActiveModel::Type::Decimal
    JSONSchemaCacheSerializer.register "integer", ActiveModel::Type::Integer
    JSONSchemaCacheSerializer.register "string", ActiveModel::Type::String
    JSONSchemaCacheSerializer.register "value", ActiveModel::Type::Value
  end
end
