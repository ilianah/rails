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

	   def +(other)
      		self.class.new(super(ERB::Util.unwrapped_html_escape(other)))
    	end
	end
end