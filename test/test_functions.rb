require 'minitest_helper'

class TestRNAseqFunctions < Minitest::Test
  def setup

  end

  def test_root_mean_squared_error
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    all_truth_estimates = [103.7,12.4,43.5,103.0,19.0,150.0]
    l = Functions.root_mean_squared_error(all_trans_estimates, all_truth_estimates)
    assert_equal(23.011, l)
  end

  def test_pearson_correlation_coefficient
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    all_truth_estimates = [103.7,12.4,43.5,103.0,19.0,150.0]
    l = Functions.pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    assert_equal(0.9574, l)
  end

  def test_squared_pearson_correlation_coefficient
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    all_truth_estimates = [103.7,12.4,43.5,103.0,19.0,150.0]
    l = Functions.squared_pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    assert_equal(0.9166, l)
  end

  def test_squared_pearson_correlation_coefficient
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    all_truth_estimates = [103.7,12.4,43.5,103.0,19.0,150.0]
    l = Functions.squared_pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    assert_equal(0.9166, l)
  end

  def test_relative_difference
    l = Functions.relative_difference(100.0,105.0)
    assert_equal(0.0488,l)
  end

  def test_median
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    l = Functions.median(all_trans_estimates)
    assert_equal(72.75, l)
  end

  def test_median_relative_difference
    all_trans_estimates = [103.5,22.4,43.5,102.0,43.0,200.0]
    all_truth_estimates = [103.7,12.4,43.5,103.0,19.0,150.0]
    l = Functions.median_relative_difference(all_trans_estimates, all_truth_estimates)
    assert_equal(0.1478, l)
  end

end
