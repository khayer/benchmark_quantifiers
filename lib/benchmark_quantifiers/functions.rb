module Functions
  def Functions.root_mean_squared_error(all_trans_estimates, all_truth_estimates)
    sum = 0
    all_truth_estimates.each_with_index do |truth,i|
      sum += (all_trans_estimates[i] - truth)**2
    end
    (Math.sqrt(sum/all_trans_estimates.length)).round(4)
  end

  def Functions.pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    average_trans = all_trans_estimates.inject{ |sum, el| sum + el }.to_f / all_trans_estimates.size
    average_truth = all_truth_estimates.inject{ |sum, el| sum + el }.to_f / all_truth_estimates.size
    # Numerator
    sum_num = 0
    all_truth_estimates.each_with_index do |truth,i|
      sum_num += ((all_trans_estimates[i] - average_trans)*
        (truth - average_truth))
    end
    # Denominator
    trans_sum = 0
    all_trans_estimates.each do |trans|
      trans_sum += (trans - average_trans)**2
    end
    truth_sum = 0
    all_truth_estimates.each do |truth|
      truth_sum += (truth - average_truth)**2
    end
    denominator = Math.sqrt(trans_sum) * Math.sqrt(truth_sum)
    (sum_num / denominator).round(4)
  end

  def Functions.squared_pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    (Functions.pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)**2).round(4)
  end
end