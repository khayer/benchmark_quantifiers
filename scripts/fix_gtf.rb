mapping = {}
File.open("IDmapping.txt").each do |line|
  line.chomp!
  fields = line.split("\t")
  mapping[fields[0]] = fields[1]
end

mapping_ens = {}
File.open("/home/hayer/index/ensembl_mm9_oct_2015_trans2gene.txt").each do |line|
  line.chomp!
  fields = line.split("\t")
  mapping_ens[fields[0]] = fields[1]
end

#puts mapping["GENE.1"]
#puts mapping_ens["ENSMUST00000072177"]

File.open("simulator_config_geneinfo_mm9-ensembl-stdchr_GTF").each do |line|
  line.chomp!
  line =~ /gene_id "(GENE\.\d*)"/
  trans_id = mapping[$1]
  gene_id = mapping_ens[trans_id]
  line.sub!(/GENE\.\d*/,gene_id)
  line.sub!(/GENE\.\d*/,trans_id)
  puts line
  #exit
end
