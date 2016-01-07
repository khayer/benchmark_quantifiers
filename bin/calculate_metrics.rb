require "benchmark_quantifiers"

# infiles:
# TranscriptLengths  TranscriptCounts mean_FLD
# outfile:
# FPKM TPM etc.
#LONG
#mean_FLD = 269.61
#std_FLD = 39.84
# MEDIUM
mean_FLD = 260
std_FLD = 45
# SHORT
#mean_FLD = 260.0
#std_FLD = 44.0
gene_to_ens = {}
ensg_to_enstrans = {}
ens_lengths = {}
ensg_lengths = {}
ens_chromosome = {}
enst_to_ensg = {}
File.open("files/transcript_length.txt").each do |line|
  line.chomp!
  next if line =~ /^GENEID/
  gene_id, enstrans, ensg_id, length, num_exon, chromosome = line.split("\t")
  gene_to_ens[gene_id] = enstrans
  ensg_to_enstrans[ensg_id] ||= []
  ensg_to_enstrans[ensg_id] << enstrans
  ens_lengths[enstrans] = length.to_i
  ensg_lengths[ensg_id] ||= 0
  ensg_lengths[ensg_id] = length.to_i unless ensg_lengths[ensg_id] > length.to_i
  enst_to_ensg[enstrans] = ensg_id
  ens_chromosome[enstrans] = chromosome
  #puts gene_to_ens
end


sum_all_counts = 0
sum_by_chromosome = {}
sum_by_ensg = {}

#File.open("files/ENS.PLD.counts_for_FPKM.txt").each do |line|
#File.open("files/ENS.PSD.counts_for_FPKM.txt").each do |line|
File.open("files/ENS.PD.counts_for_FPKM.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  gene_id, cnt = line.split("\t")
  sum_all_counts += cnt.to_i/2.0
  sum_by_chromosome[ens_chromosome[gene_to_ens[gene_id]]] ||= 0
  sum_by_chromosome[ens_chromosome[gene_to_ens[gene_id]]] += cnt.to_i/2.0
  sum_by_ensg[enst_to_ensg[gene_to_ens[gene_id]]] ||= 0
  sum_by_ensg[enst_to_ensg[gene_to_ens[gene_id]]] += cnt.to_i/2.0
end

#puts sum_by_ensg
#exit
#puts sum_by_chromosome
#exit

#puts sum_all_counts
# 2,000,000,000

fpkm_per_transcript = {}
fpkm_per_transcript_by_chr = {}
effective_length_per_transcript = {}
fpkm_sum_over_all_transcripts_by_chr = {}
fpkm_sum_over_all_transcripts = 0
abundance = {}
fpkm_per_gene = {}
#File.open("files/ENS.PLD.counts_for_FPKM.txt").each do |line|
#File.open("files/ENS.PSD.counts_for_FPKM.txt").each do |line|
File.open("files/ENS.PD.counts_for_FPKM.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  gene_id, cnt = line.split("\t")
  transcript_length = ens_lengths[gene_to_ens[gene_id]]
  #if mean_FLD > transcript_length
  #  mean_FLD = transcript_length
  #end
  effective_length = RNAseqFunctions.effective_length(transcript_length, mean_FLD)
  ##if effective_length < 0
  ##  effective_length += std_FLD
  ##end
  ##if effective_length <= 0
  ##  effective_length = 1
  ##end
  effective_length = transcript_length
  effective_length_per_transcript[gene_to_ens[gene_id]] = effective_length
  #puts effective_length
  #exit

  #if k.infinite?
  #  puts cnt.to_i/2
  #  puts effective_length
  #  puts sum_all_counts
  #  exit
  #end
  k = RNAseqFunctions.fpkm(cnt.to_i/2, effective_length, sum_all_counts)
  fpkm_per_transcript[gene_to_ens[gene_id]] = k
  fpkm_sum_over_all_transcripts += k
  k = RNAseqFunctions.fpkm(cnt.to_i/2, effective_length, sum_by_chromosome[ens_chromosome[gene_to_ens[gene_id]]])
  fpkm_per_transcript_by_chr[gene_to_ens[gene_id]] = k
  abundance[gene_to_ens[gene_id]] = (cnt.to_i/2)/sum_by_ensg[enst_to_ensg[gene_to_ens[gene_id]]]
  fpkm_sum_over_all_transcripts_by_chr[ens_chromosome[gene_to_ens[gene_id]]] ||= 0
  fpkm_sum_over_all_transcripts_by_chr[ens_chromosome[gene_to_ens[gene_id]]] += k

  k = RNAseqFunctions.fpkm(sum_by_ensg[enst_to_ensg[gene_to_ens[gene_id]]], ensg_lengths[enst_to_ensg[gene_to_ens[gene_id]]], sum_all_counts)
  fpkm_per_gene[enst_to_ensg[gene_to_ens[gene_id]]] = k
  #puts fpkm_per_transcript
  #exit
end


#puts fpkm_per_gene
#uts fpkm_per_gene["ENSMUSG00000089699"]
#exit

#puts abundance
#exit
#puts fpkm_per_transcript
#puts fpkm_sum_over_all_transcripts_by_chr
tpm_per_transcript = {}
tpm_per_transcript_by_chr = {}
fpkm_per_transcript.each_pair do |key,value|
  k = RNAseqFunctions.tpm_from_fpkm(value, fpkm_sum_over_all_transcripts)
  tpm_per_transcript[key] = k
  k = RNAseqFunctions.tpm_from_fpkm(value, fpkm_sum_over_all_transcripts_by_chr[ens_chromosome[key]])
  tpm_per_transcript_by_chr[key] = k

end

puts tpm_per_transcript

#out_file = File.open("files/transcript_metrics_ENS.PLD.txt", "w")
#out_file = File.open("files/transcript_metrics_ENS.PSD.txt_new", "w")
out_file = File.open("files/transcript_metrics_ENS.PD.txt", "w")
out_file.puts "GENEID\ttrans_id\tgene_id\tlength\t#transcripts\tchromosome\teffective_length\tFPKM\tTPM\tFPKM_by_Chr\tTPM_by_Chr\t#isoforms\tabundance"
File.open("files/transcript_length.txt").each do |line|
  line.chomp!
  next if line =~ /^GENEID/
  gene_id, enstrans, ensg_id, length, num_exon, chromosome = line.split("\t")
  if effective_length_per_transcript[enstrans]
    out_file.puts "#{line}\t#{effective_length_per_transcript[enstrans]}\t#{fpkm_per_transcript[enstrans]}\t#{tpm_per_transcript[enstrans]}\t#{fpkm_per_transcript_by_chr[enstrans]}\t#{tpm_per_transcript_by_chr[enstrans]}\t#{ensg_to_enstrans[ensg_id].length}\t#{abundance[enstrans]}"
  else
    effective_length = RNAseqFunctions.effective_length(length.to_i, mean_FLD)
    #if effective_length < 0
    #  effective_length += std_FLD
    #end
    #if effective_length < 0
    #  effective_length = 1
    #end
    effective_length = length.to_i
    out_file.puts "#{line}\t#{effective_length}\t0\t0\t#{ensg_to_enstrans[ensg_id].length}\t0"
  end
end

out_file.close
