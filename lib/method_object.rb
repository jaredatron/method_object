require File.expand_path('../method_object/version', __FILE__)

class MethodObject

  class << self

    private :new
    def call *args
      new.call(*args)
    end

    def to_proc
      method(:call).to_proc
    end

  end

end

eval <<-RUBY if $0 == __FILE__

require 'test/unit'

# example method objects
class FindTreasureChest < MethodObject
  def call *args
    args + [:treasure_chest]
  end
end

#tests
class MethodObjectTestUnitTestCase < Test::Unit::TestCase

  def test_method_objects_have_private_new_method
    assert_raises(NoMethodError){ FindTreasureChest.new }
  end

  def test_unknown_options
    assert_equal FindTreasureChest.call, [:treasure_chest]
  end

  def test_that_expected_options_are_ok
    assert_equal FindTreasureChest.call(:a, :size => 42), [:a, {:size => 42}, :treasure_chest]
  end

  def test_to_proc
    assert_equal FindTreasureChest.to_proc.call, [:treasure_chest]
    assert_equal FindTreasureChest.to_proc.call(:foo), [:foo, :treasure_chest]
  end

end

RUBY
