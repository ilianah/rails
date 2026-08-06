# frozen_string_literal: true

require "active_record/connection_adapters/postgresql/oid/array"
require "active_record/connection_adapters/postgresql/oid/bit"
require "active_record/connection_adapters/postgresql/oid/bit_varying"
require "active_record/connection_adapters/postgresql/oid/bytea"
require "active_record/connection_adapters/postgresql/oid/cidr"
require "active_record/connection_adapters/postgresql/oid/date"
require "active_record/connection_adapters/postgresql/oid/date_time"
require "active_record/connection_adapters/postgresql/oid/decimal"
require "active_record/connection_adapters/postgresql/oid/enum"
require "active_record/connection_adapters/postgresql/oid/hstore"
require "active_record/connection_adapters/postgresql/oid/inet"
require "active_record/connection_adapters/postgresql/oid/interval"
require "active_record/connection_adapters/postgresql/oid/jsonb"
require "active_record/connection_adapters/postgresql/oid/macaddr"
require "active_record/connection_adapters/postgresql/oid/money"
require "active_record/connection_adapters/postgresql/oid/oid"
require "active_record/connection_adapters/postgresql/oid/point"
require "active_record/connection_adapters/postgresql/oid/legacy_point"
require "active_record/connection_adapters/postgresql/oid/range"
require "active_record/connection_adapters/postgresql/oid/specialized_string"
require "active_record/connection_adapters/postgresql/oid/timestamp"
require "active_record/connection_adapters/postgresql/oid/timestamp_with_time_zone"
require "active_record/connection_adapters/postgresql/oid/uuid"
require "active_record/connection_adapters/postgresql/oid/vector"
require "active_record/connection_adapters/postgresql/oid/xml"

require "active_record/connection_adapters/postgresql/oid/type_map_initializer"
require "active_record/connection_adapters/postgresql/oid/well_known"

module ActiveRecord
  module ConnectionAdapters
    module PostgreSQL
      module OID # :nodoc:
      end

      JSONSchemaCacheSerializer.register "postgresql_array", OID::Array
      JSONSchemaCacheSerializer.register "postgresql_bit", OID::Bit
      JSONSchemaCacheSerializer.register "postgresql_bit_varying", OID::BitVarying
      JSONSchemaCacheSerializer.register "postgresql_bytea", OID::Bytea
      JSONSchemaCacheSerializer.register "postgresql_cidr", OID::Cidr
      JSONSchemaCacheSerializer.register "postgresql_date", OID::Date
      JSONSchemaCacheSerializer.register "postgresql_date_time", OID::DateTime
      JSONSchemaCacheSerializer.register "postgresql_decimal", OID::Decimal
      JSONSchemaCacheSerializer.register "postgresql_enum", OID::Enum
      JSONSchemaCacheSerializer.register "postgresql_hstore", OID::Hstore
      JSONSchemaCacheSerializer.register "postgresql_inet", OID::Inet
      JSONSchemaCacheSerializer.register "postgresql_interval", OID::Interval
      JSONSchemaCacheSerializer.register "postgresql_jsonb", OID::Jsonb
      JSONSchemaCacheSerializer.register "postgresql_legacy_point", OID::LegacyPoint
      JSONSchemaCacheSerializer.register "postgresql_macaddr", OID::Macaddr
      JSONSchemaCacheSerializer.register "postgresql_money", OID::Money
      JSONSchemaCacheSerializer.register "postgresql_point", OID::Point
      JSONSchemaCacheSerializer.register "postgresql_range", OID::Range
      JSONSchemaCacheSerializer.register "postgresql_specialized_string", OID::SpecializedString
      JSONSchemaCacheSerializer.register "postgresql_timestamp", OID::Timestamp
      JSONSchemaCacheSerializer.register "postgresql_timestamp_with_time_zone", OID::TimestampWithTimeZone
      JSONSchemaCacheSerializer.register "postgresql_uuid", OID::Uuid
      JSONSchemaCacheSerializer.register "postgresql_vector", OID::Vector
      JSONSchemaCacheSerializer.register "postgresql_xml", OID::Xml
    end
  end
end
