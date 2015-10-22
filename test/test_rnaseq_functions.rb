require 'minitest_helper'

class TestRNAseqFunctions < Minitest::Test
  def setup

  end

  def test_effective_length
    l = RNAseqFunctions.effective_length(43553,213.96)
    assert_equal(43340.04, l)
  end

  def test_that_will_be_skipped
    #skip "test this later"
  end
end
