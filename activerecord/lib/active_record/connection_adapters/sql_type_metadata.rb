# frozen_string_literal: true

module ActiveRecord
  # :stopdoc:
  module ConnectionAdapters
    class SqlTypeMetadata
      include Deduplicable

      attr_reader :sql_type, :type, :limit, :precision, :scale

      def initialize(sql_type: nil, type: nil, limit: nil, precision: nil, scale: nil)
        @sql_type = sql_type
        @type = type
        @limit = limit
        @precision = precision
        @scale = scale
      end

      def ==(other)
        other.is_a?(SqlTypeMetadata) &&
          sql_type == other.sql_type &&
          type == other.type &&
          limit == other.limit &&
          precision == other.precision &&
          scale == other.scale
      end
      alias eql? ==

      def hash
        [
          SqlTypeMetadata,
          @sql_type,
          @type,
          @limit,
          @precision,
          @scale,
        ].hash
      end

      def as_schema_json
        data = {}
        data["_type"] = self.class.name
        self.instance_variables.each do |name|
          data[name] = instance_variable_get(name)
        end 
        data
      end

      
      def init_from_schema_json(coder)
        coder.each do |key, value|
          next if key == "_type"
          self.instance_variable_set(key, value)
        end
      end

      private
        def deduplicated
          @sql_type = -sql_type
          super
        end
    end
  end
end
