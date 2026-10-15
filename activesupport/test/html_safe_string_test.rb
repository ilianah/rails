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

	test "review all" do 
		pending = ActiveSupport::HTMLSafeString.public_instance_methods - REVIEWED
		assert_empty pending
	end

	test "html escape"  do
		assert_equal "<html>", ERB::Util.unwrapped_html_escape(ActiveSupport::HTMLSafeString.new("<html>"))
	end

	test "html escape old" do
		assert_equal "<html>", ERB::Util.unwrapped_html_escape(ActiveSupport::SafeBuffer.new("<html>"))
	end

	test "to str" do
		assert_equal String, @str.to_str.class
	end

	MUTATION_METHODS = Set[
		:upcase!,
		:capitalize!,
		:append_as_bytes,
		:bitwise_not!,
		:chomp!,
		:chop!,
		:clear,
		:concat,
		:downcase!,
		:encode!,
		:gsub!,
		:lstrip!,
		:next!,
		:prepend,
		:reverse!,
		:rstrip!,
		:squeeze!,
		:squish!,
		:strip!,
		:succ!,
		:swapcase!,
		:unicode_normalize!
	]

	SAFE_METHODS = [
		:dedup,
		:freeze,
		:-@
	]

	METHOD_ARGUMENTS = {
		:+ => [["hello"], {}, nil]
	}

	NEW_OBJECT_METHODS = [
		:upcase,
		:capitalize
	]

	OTHER = [
	]

	REVIEWED = SAFE_METHODS + MUTATION_METHODS.to_a + NEW_OBJECT_METHODS + OTHER

	MUTATION_METHODS.each do |method|
		test "##{method} raises FrozenError" do
			args, kwargs, block = METHOD_ARGUMENTS[method]
			assert_raises(FrozenError) do
				@str.public_send(method, *args, **kwargs, &block)
			end
		end
	end

	NEW_OBJECT_METHODS.each do |method|
		test "##{method} does not return an html safe result" do
			args, kwargs, block = METHOD_ARGUMENTS[method]
			result = @str.public_send(method, *args, **kwargs, &block)
			refute_predicate result, :html_safe?
		end
	end

end