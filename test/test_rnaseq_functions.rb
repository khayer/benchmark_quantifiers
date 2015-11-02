require 'minitest_helper'

class TestRNAseqFunctions < Minitest::Test
  def setup
    @effective_length = RNAseqFunctions.effective_length(2928,213.96)
    @number_of_assigned_reads = 80*10**6
  end

  def test_effective_length
    l = RNAseqFunctions.effective_length(43553,213.96)
    assert_equal(43340.04, l)
  end

  def test_effective_count
    l = RNAseqFunctions.effective_count(874, 2928, @effective_length)
    assert_equal(942.5541, l)
  end

  def test_counts_per_million
    l = RNAseqFunctions.counts_per_million(70000, @number_of_assigned_reads)
    assert_equal(875.0, l)
  end


  def test_fpkm
    l = RNAseqFunctions.fpkm(80, @effective_length, @number_of_assigned_reads)
    assert_equal(2715040.0, l)
  end

  def test_that_will_be_skipped
    #skip "test this later"
  end
end
