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
	end
end