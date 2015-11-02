module RNAseqFunctions
  # FLD = fragment length distribution
  def RNAseqFunctions.effective_length(transcript_length, mean_FLD)
    transcript_length - mean_FLD.to_f + 1.0
  end

  def RNAseqFunctions.effective_count(raw_count, transcript_length, effective_length)
    (raw_count * (transcript_length / effective_length.to_f)).round(4)
  end

  def RNAseqFunctions.counts_per_million(raw_count, number_of_assigned_reads)
    ((raw_count.to_f / number_of_assigned_reads.to_f) * (10.0 ** 6)).round(4)
  end

  # Transcripts per million (TPM)
  #def RNAseqFunctions.tpm(raw_count, effective_length, sum_over_all_transcripts)
  #  x = 1 / (sum_over_all_transcripts)
  #  ((raw_count.to_f /effective_length.to_f) * x * (10.0 ** 6)).round(4)
  #end

  #def RNAseqFunctions.sum_over_all_transcripts()
  #  #TODO
  #  return
  #end

  # Fragments per kilobase of exon per million reads mapped
  def RNAseqFunctions.fpkm(raw_count, effective_length, number_of_assigned_reads)
    (raw_count.to_f / number_of_assigned_reads.to_f * effective_length * (10.0 ** 9)).round(4)
  end

  def RNAseqFunctions.tpm_from_fpkm(fpkm_current, fpkm_sum_over_all_transcripts)
    ((fpkm_current.to_f / fpkm_sum_over_all_transcripts.to_f) * (10.0 ** 6)).round(4)
  end

  #def RNAseqFunctions.fpkm_sum_over_all_transcripts()
  #  #TODO
  #end
end