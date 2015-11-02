require "benchmark_quantifiers"

# infiles:
# TranscriptLengths  TranscriptCounts mean_FLD 
# outfile:
# FPKM TPM etc.

mean_FLD = 269.61
gene_to_ens = {}
ensg_to_enstrans = {}
ens_lengths = {}
File.open("files/transcript_length.txt").each do |line|
  line.chomp!
  next if line =~ /^GENEID/
  gene_id, enstrans, ensg_id, length = line.split("\t")
  gene_to_ens[gene_id] = enstrans
  ensg_to_enstrans[ensg_id] ||= []
  ensg_to_enstrans[ensg_id] << enstrans
  ens_lengths[enstrans] = length.to_i
  #puts gene_to_ens
end

sum_all_counts = 0
File.open("files/ENS.PLD.counts_for_FPKM.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  gene_id, cnt = line.split("\t")
  sum_all_counts += cnt.to_i/2.0
end

#puts sum_all_counts
# 2,000,000,000

fpkm_per_transcript = {}
fpkm_sum_over_all_transcripts = 0
File.open("files/ENS.PLD.counts_for_FPKM.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  gene_id, cnt = line.split("\t")
  transcript_length = ens_lengths[gene_to_ens[gene_id]]
  effective_length = RNAseqFunctions.effective_length(transcript_length, mean_FLD)
  #puts effective_length 
  #exit
  k = RNAseqFunctions.fpkm(cnt.to_i/2, effective_length, sum_all_counts)
  fpkm_per_transcript[gene_to_ens[gene_id]] = k
  fpkm_sum_over_all_transcripts += k
  #puts fpkm_per_transcript
  #exit
end

puts fpkm_per_transcript

tpm_per_transcript = {}
fpkm_per_transcript.each_pair do |key,value|

  k = RNAseqFunctions.tpm_from_fpkm(value, fpkm_sum_over_all_transcripts)
  tpm_per_transcript[key] = k
end

puts tpm_per_transcript