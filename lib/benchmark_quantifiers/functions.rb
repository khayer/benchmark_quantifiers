module Functions

  def Functions.median(array)
    #$logger.debug("#{array}")
    sorted = array.sort
    len = sorted.length
    ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).round(4)
  end

  # https://en.wikipedia.org/wiki/Relative_change_and_difference
  def Functions.relative_difference(estimate,truth)
    return 0 if estimate == 0 && truth == 0
    #$logger.debug("#{estimate} #{truth}")
    ((truth-estimate).abs/((truth.abs+estimate.abs)/2)).round(4)
  end

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

  def Functions.median_relative_difference(all_trans_estimates, all_truth_estimates)
    tmp = []
    all_trans_estimates.each_with_index do |trans, i|
      tmp << Functions.relative_difference(trans,all_truth_estimates[i])
    end
    Functions.median(tmp)
  end

  def Functions.compare(truth, estimated)
    all_trans_estimates = []
    all_truth_estimates = []
    truth_copy = truth.dup
    estimated.each_pair do |key,value|
      next unless truth[key]
      $logger.debug truth[key]
      all_trans_estimates << value
      all_truth_estimates << truth[key]
      $logger.debug key
      truth_copy.delete(key)
    end
    truth_copy.each_pair do |key,value|
      all_trans_estimates << 0.0
      all_truth_estimates << value
    end
    rmse = Functions.root_mean_squared_error(all_trans_estimates, all_truth_estimates)
    pcc = Functions.pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    spcc = Functions.squared_pearson_correlation_coefficient(all_trans_estimates, all_truth_estimates)
    mrd = Functions.median_relative_difference(all_trans_estimates, all_truth_estimates)
    [rmse, pcc, spcc, mrd]
  end

  def Functions.print(truth, estimated)
    truth_copy = truth.dup
    puts "ENSTID\tTRUTH\tESTIMATED"
    estimated.each_pair do |key,value|
      next unless truth[key]
      puts "#{key}\t#{truth[key]}\t#{value}"
      truth_copy.delete(key)
    end
    truth_copy.each_pair do |key,value|
      puts "#{key}\t#{value}\t0.0"
    end
  end

  def Functions.replace_geneids(geneid_to_transid, estimated)
    estimated_new = {}
    estimated.each_pair do |key, value|
      estimated_new[geneid_to_transid[key]] = value
    end
    estimated_new
  end


end