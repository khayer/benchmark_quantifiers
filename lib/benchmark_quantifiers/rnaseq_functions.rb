module RNAseqFunctions
  # FLD = fragment length distribution
  def RNAseqFunctions.effective_length(transcript_length, mean_FLD)
    transcript_length - mean_FLD + 1
  end
end