# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def test_stack_is_empty
    assert_equal @stack.to_a, []
  end

  def test_stack_push
    @stack.push! 'ruby'
    assert_equal @stack.to_a, ['ruby']
  end

  def test_stack_pop
    @stack.pop!
    assert_equal @stack.to_a, []
  end

  def test_stack_clear
    @stack.push! 'ruby'
    assert_equal @stack.to_a, ['ruby']

    @stack.clear!
    assert_equal @stack.to_a, []
  end

  def test_stack_empty
    assert_equal @stack.empty?, true

    @stack.push! 'ruby'
    assert_equal @stack.to_a, ['ruby']

    assert_equal @stack.empty?, false
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
