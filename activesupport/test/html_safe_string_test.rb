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

  test "clone(freeze: false)" do
    refute_predicate @str.clone(freeze: false), :html_safe?
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
    :unicode_normalize!,
    :<<,
    :[]=,
    :bit_clear,
    :bit_flip,
    :bit_set,
    :bitwise_and!,
    :bitwise_or!,
    :bitwise_xor!,
    :bytesplice,
    :delete!,
    :delete_prefix!,
    :delete_suffix!,
    :force_encoding,
    :indent!,
    :insert,
    :remove!,
    :replace,
    :scrub!,
    :setbyte,
    :slice!,
    :sub!,
    :tr!,
    :tr_s!
  ]

  SAFE_METHODS = [
    :dedup,
    :freeze,
    :-@,
    :+,
    :clamp,
    :clone,
    :demodulize,
    :encode,
    :html_safe,
    :itself,
    :presence,
    :strip_heredoc,
    :to_s
  ]

  METHOD_ARGUMENTS = {
    :+ => [["hello"], {}, nil],
    :% => [["x"], {}, nil, "%s"],
    :* => [[2], {}, nil],
    :[] => [[0, 2], {}, nil],
    :<< => [["x"], {}, nil],
    :[]= => [[0, "x"], {}, nil],
    :at => [[0], {}, nil],
    :bit_clear => [[0], {}, nil],
    :bit_flip => [[0], {}, nil],
    :bit_set => [[0], {}, nil],
    :bitwise_and => [["abcd"], {}, nil],
    :bitwise_and! => [["abcd"], {}, nil],
    :bitwise_or => [["abcd"], {}, nil],
    :bitwise_or! => [["abcd"], {}, nil],
    :bitwise_xor => [["abcd"], {}, nil],
    :bitwise_xor! => [["abcd"], {}, nil],
    :byteslice => [[0, 2], {}, nil],
    :bytesplice => [[0, 1, "x"], {}, nil],
    :center => [[10], {}, nil],
    :clamp => [["a", "z"], {}, nil],
    :crypt => [["ab"], {}, nil],
    :delete => [["t"], {}, nil],
    :delete! => [["t"], {}, nil],
    :delete_prefix => [["t"], {}, nil],
    :delete_prefix! => [["t"], {}, nil],
    :delete_suffix => [["t"], {}, nil],
    :delete_suffix! => [["t"], {}, nil],
    :force_encoding => [["BINARY"], {}, nil],
    :from => [[1], {}, nil],
    :gsub => [["t", "x"], {}, nil],
    :indent => [[2], {}, nil],
    :indent! => [[2], {}, nil],
    :insert => [[0, "x"], {}, nil],
    :ljust => [[10], {}, nil],
    :remove => [["t"], {}, nil],
    :remove! => [["t"], {}, nil],
    :replace => [["x"], {}, nil],
    :rjust => [[10], {}, nil],
    :scrub! => [[], {}, nil, "\xFF"],
    :setbyte => [[0, 65], {}, nil],
    :slice => [[0, 2], {}, nil],
    :slice! => [[0], {}, nil],
    :sub => [["t", "x"], {}, nil],
    :sub! => [["t", "x"], {}, nil],
    :to => [[1], {}, nil],
    :to_query => [["k"], {}, nil],
    :tr => [["t", "x"], {}, nil],
    :tr! => [["t", "x"], {}, nil],
    :tr_s => [["t", "x"], {}, nil],
    :tr_s! => [["t", "x"], {}, nil],
    :truncate => [[2], {}, nil],
    :truncate_bytes => [[10], {}, nil],
    :truncate_words => [[1], {}, nil]
  }

  NEW_OBJECT_METHODS = [
    :upcase,
    :capitalize,
    :%,
    :*,
    :+@,
    :[],
    :as_json,
    :at,
    :b,
    :bitwise_and,
    :bitwise_not,
    :bitwise_or,
    :bitwise_xor,
    :byteslice,
    :camelcase,
    :camelize,
    :center,
    :chomp,
    :chop,
    :chr,
    :classify,
    :crypt,
    :dasherize,
    :deconstantize,
    :deep_dup,
    :delete,
    :delete_prefix,
    :delete_suffix,
    :downcase,
    :downcase_first,
    :dump,
    :dup,
    :first,
    :foreign_key,
    :from,
    :gsub,
    :humanize,
    :indent,
    :inquiry,
    :inspect,
    :last,
    :ljust,
    :lstrip,
    :next,
    :parameterize,
    :pluralize,
    :remove,
    :reverse,
    :rjust,
    :rstrip,
    :scrub,
    :shellescape,
    :singularize,
    :slice,
    :squeeze,
    :squish,
    :strip,
    :sub,
    :succ,
    :swapcase,
    :tableize,
    :titlecase,
    :titleize,
    :to,
    :to_json,
    :to_param,
    :to_query,
    :to_str,
    :to_yaml,
    :tr,
    :tr_s,
    :truncate,
    :truncate_bytes,
    :truncate_words,
    :underscore,
    :unicode_normalize,
    :upcase_first
  ]

  OTHER = [
    :require_dependency,
    :html_safe?,
    :encode_with,
    :try,
    :try!,
    :!,
    :!=,
    :__id__,
    :__send__,
    :equal?,
    :instance_eval,
    :instance_exec,
    :<,
    :<=,
    :>,
    :>=,
    :between?,
    :!~,
    :class,
    :class_eval,
    :define_singleton_method,
    :display,
    :enum_for,
    :extend,
    :frozen?,
    :instance_of?,
    :instance_variable_defined?,
    :instance_variable_get,
    :instance_variable_set,
    :instance_variables,
    :is_a?,
    :kind_of?,
    :method,
    :methods,
    :nil?,
    :object_id,
    :pretty_inspect,
    :private_methods,
    :protected_methods,
    :public_method,
    :public_methods,
    :public_send,
    :remove_instance_variable,
    :respond_to?,
    :send,
    :singleton_class,
    :singleton_method,
    :singleton_methods,
    :tap,
    :then,
    :to_enum,
    :yield_self,
    :to_msgpack,
    :acts_like?,
    :duplicable?,
    :in?,
    :instance_values,
    :instance_variable_names,
    :presence_in,
    :stub,
    :with,
    :with_options,
    :pretty_print_cycle,
    :pretty_print_inspect,
    :pretty_print_instance_variables,
    :<=>,
    :==,
    :===,
    :=~,
    :acts_like_string?,
    :ascii_only?,
    :bit_count,
    :bit_get,
    :bit_set?,
    :blank?,
    :byteindex,
    :byterindex,
    :bytes,
    :bytesize,
    :casecmp,
    :casecmp?,
    :chars,
    :codepoints,
    :constantize,
    :count,
    :each_byte,
    :each_char,
    :each_codepoint,
    :each_grapheme_cluster,
    :each_line,
    :empty?,
    :encoding,
    :end_with?,
    :ends_with?,
    :eql?,
    :exclude?,
    :ext,
    :getbyte,
    :grapheme_clusters,
    :hash,
    :hex,
    :in_time_zone,
    :include?,
    :index,
    :intern,
    :is_utf8?,
    :length,
    :lines,
    :match,
    :match?,
    :oct,
    :ord,
    :partition,
    :pathmap,
    :present?,
    :pretty_print,
    :rindex,
    :rpartition,
    :safe_constantize,
    :scan,
    :shellsplit,
    :size,
    :split,
    :start_with?,
    :starts_with?,
    :sum,
    :to_c,
    :to_d,
    :to_date,
    :to_datetime,
    :to_f,
    :to_i,
    :to_r,
    :to_sym,
    :to_time,
    :undump,
    :unicode_normalized?,
    :unpack,
    :unpack1,
    :upto,
    :valid_encoding?
  ]

  REVIEWED = SAFE_METHODS + MUTATION_METHODS.to_a + NEW_OBJECT_METHODS + OTHER

  MUTATION_METHODS.each do |method|
    test "##{method} raises FrozenError" do
      assert_raises(FrozenError) do
        call(method)
      end
    end
  end

  SAFE_METHODS.each do |method|
    test "##{method} returns a frozen html safe result" do
      result = call(method)
      assert_predicate result, :html_safe?
      assert_predicate result, :frozen?
    end
  end

  NEW_OBJECT_METHODS.each do |method|
    test "##{method} does not return an html safe result" do
      result = call(method)
      refute_predicate result, :html_safe?
    end
  end

  private
    def call(method)
      args, kwargs, block, receiver = METHOD_ARGUMENTS.fetch(method, [[], {}, nil])
      str = receiver ? ActiveSupport::HTMLSafeString.new(receiver) : @str
      skip "##{method} is not defined here" unless str.respond_to?(method)
      str.public_send(method, *args, **kwargs, &block)
    end

end
