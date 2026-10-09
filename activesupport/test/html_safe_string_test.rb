# frozen_string_literal: true

require_relative "abstract_unit"
require "active_support/core_ext/string/output_safety"

class HTMLSafeStringTest < ActiveSupport::TestCase

	setup do
		@str = ActiveSupport::HTMLSafeString.new("test")
	end

	test "test" do
		assert_predicate @str, :html_safe?
	end


	MUTATION_METHODS = Set[
		:upcase!,
		:capitalize!
	]

	SAFE_METHODS = [
		:dedup,
		:freeze,
		:'@-',
	]

	METHOD_ARGUMENTS = {
		:+ => [["hello"], {}, nil]
	}

	(ActiveSupport::HTMLSafeString.public_instance_methods - SAFE_METHODS).each do |method|
		test "##{method} is handled safely" do
			args, kwargs, block = METHOD_ARGUMENTS[method]
			if MUTATION_METHODS.include?(method)
				assert_raises(FrozenError) do				
					result = @str.public_send(method, *args, **kwargs, &block)
				end
			else 
				result = @str.public_send(method, *args, **kwargs, &block)
				refute_predicate result, :html_safe?
			end
		end
	end

end