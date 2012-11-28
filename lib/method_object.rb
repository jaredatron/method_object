require 'simple_struct'

class MethodObject < SimpleStruct

  VERSION = "0.0.2"

  class << self

    def new *members, &block
      subclass = super(*members, &block)
      subclass.send(:private_class_method, :new)
      subclass
    end

    def call *args
      new(*args).call
    end

    def to_proc
      method(:call).to_proc
    end

  end

end

eval <<-RUBY if $0 == __FILE__

require 'test/unit'

# example method objects
FindTreasureChest = MethodObject.new(:color, :size) do
  def call
    [@color, @size, :treasure_chest]
  end
end

#tests
class MethodObjectTestUnitTestCase < Test::Unit::TestCase

  def test_method_objects_have_private_new_method
    assert_raises(NoMethodError){ FindTreasureChest.new }
  end

  def test_that_expected_options_are_ok
    run_proc_tests FindTreasureChest
  end

  def test_to_proc
    run_proc_tests FindTreasureChest.to_proc
  end

  def run_proc_tests proc
    assert_equal proc.call,           [nil,  nil, :treasure_chest]
    assert_equal proc.call(:red),     [:red, nil, :treasure_chest]
    assert_equal proc.call(:red, 42), [:red,  42, :treasure_chest]
  end

end

RUBY
