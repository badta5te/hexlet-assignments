# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def test_if_stack_contains_added_element
    @stack.push!(5)

    assert { @stack.to_a.first == 5 }
  end

  def test_if_stack_does_not_contain_the_element
    @stack.push!(5)
    @stack.pop!

    assert { @stack.empty? }
  end

  def test_if_stack_is_clean
    @stack.push!(5)
    @stack.push!(6)
    @stack.clear!

    assert { @stack.empty? }
  end

  def test_if_stack_is_empty
    @stack.push!(5)
    @stack.push!(6)
    @stack.pop!
    @stack.pop!

    assert { @stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
