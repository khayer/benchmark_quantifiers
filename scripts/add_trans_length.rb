lengths = {}
num_exons = {}
chromosome = {}
File.open("../annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF").each do |line|
  line.chomp!
  line =~ /gene_id "(GENE\.\d*)"/
  id = $1
  lengths[id] ||= 0
  fields = line.split("\t")
  next unless fields[2] == "exon"
  lengths[id] += fields[4].to_i - fields[3].to_i + 1
  num_exons[id] ||= 0
  num_exons[id] += 1
  chromosome[id] = fields[0]
end

#puts lengths["GENE.7"]

mapping = {}
File.open("../annotation/IDmapping.txt").each do |line|
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

puts "GENEID\ttrans_id\tgene_id\tlength\t#exons"
lengths.each_pair do |key, value|
  puts "#{key}\t#{mapping[key]}\t#{mapping_ens[mapping[key]]}\t#{value}\t#{num_exons[key]}\t#{chromosome[key]}"
end
