require 'test_helper'

module SeatingAlgorithm
  class RunnerTest < MiniTest::Test

    def test_call_method_exists?
      instance = Runner.new
      assert_equal true, instance.respond_to?(:call)
    end

  end
end