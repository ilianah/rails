# frozen_string_literal: true

require "json"

module ActiveRecord
  module ConnectionAdapters
    class JSONSchemaCacheSerializer
      
      loading_proc = ->(object) do
        if object.is_a?(Hash) && object.key?("_type")
          klass = object["_type"].constantize
          instance = klass.allocate
          instance.init_from_schema_json(object)
          instance
        else
          object
        end
      end

      CODER = JSON::Coder.new(indent: '  ', space: ' ', object_nl: "\n", array_nl: "\n", on_load: loading_proc) do |object, is_key|
        object.as_schema_json
      end

      class << self
        def dump(cache)
          CODER.dump(cache.as_schema_json)
        end

        def load(data)
          CODER.load(data)
        end 
      end
    end
  end
end


