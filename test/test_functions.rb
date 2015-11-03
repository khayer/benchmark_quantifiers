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

end
