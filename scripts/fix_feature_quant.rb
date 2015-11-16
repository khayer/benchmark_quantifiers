# In feature_quant real_counts
# out feature_quant with actual counts
feature_quant = ARGV[0]
counts = ARGV[1]

#gene  CNT
#GENE.71689  8086
#GENE.5331 4222
#GENE.66357  82
#GENE.15839  5780
#GENE.519  898
#GENE.62759  54052
#GENE.84378  4080
#GENE.33606  133340
#GENE.18031  8388
counts_by_trans = {}
File.open(counts).each do |line|
  line.chomp!
  fields = line.split("\t")
  counts_by_trans[fields[0]] = fields[1]
end


#[hayer@node063 annotation]$ head simulator_config_featurequantifications_mm9-ensembl-stdchr
#--------------------------------------------------------------------
#GENE.1  +
#Type  Location  Count
#transcript  chr1:134212703-134229870  1879
#  exon 1  chr1:134212703-134213049  222
#intron 1  chr1:134213050-134221529  84
#  exon 2  chr1:134221530-134221650  77
#intron 2  chr1:134221651-134222782  11
#  exon 3  chr1:134222783-134222806  15

current_gene = ""
File.open(feature_quant).each do |line|
  line.chomp!
  if line =~ /^GENE/
    current_gene = line.split(" ")[0]
  end
  if line =~ /^transcript/
    fields = line.split("\t")
    fields[-1] =  counts_by_trans[current_gene]
    fields[-1] = 0 if fields[-1] == ""
    puts fields.join("\t")
  else
    puts line
  end

end
