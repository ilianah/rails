# :markup: markdown
# frozen_string_literal: true

module ActiveSupport
  class HTMLSafeString < String
    def initialize(...)
      super
      freeze
    end

    def html_safe?
      true
    end

    def to_s
      self
    end

    def as_json(*)
      to_str
    end

    def to_param
      to_str
    end

    def encode_with(coder)
      coder.represent_object nil, to_str
    end

    def +(other)
      self.class.new(super(ERB::Util.unwrapped_html_escape(other)))
    end

    def dup
      String.new(self)
    end

    def +@
      String.new(self)
    end

    def clone(freeze: nil)
      freeze == false ? String.new(self) : super
    end

    def encode(...)
      self.class.new(super)
    end
  end
end
