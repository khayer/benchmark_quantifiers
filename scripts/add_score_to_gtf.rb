mapping = {}
File.open("IDmapping.txt").each do |line|
  line.chomp!
  fields = line.split("\t")
  mapping[fields[0]] = fields[1]
end

num = {}
current_name = ""
File.open("simulator_config_featurequantifications_mm9-ensembl-stdchr").each do |line|
  line.chomp!
  if line =~ /^GENE/
    current_name = mapping[line.split("\t")[0]]
  end
  if line =~ /^transcript/
    num[current_name] = line.split("\t")[-1].to_i
  end
end
#puts mapping["GENE.1"]
#puts mapping_ens["ENSMUST00000072177"]

File.open("simulator_config_geneinfo_mm9-ensembl-stdchr_GTF.gtf").each do |line|
  line.chomp!
  if line =~ /^track/
    puts line 
    next
  end
  line =~ /transcript_id \"(ENSMUST\d*)\"/
  trans_id = $1
  #puts trans_id
  fields = line.split("\t")
  case 
  when num[trans_id] > 225
    fields[5] = 999
  when num[trans_id] > 0
    fields[5] = 499
  else
    fields[5] = 1
  end
  puts fields.join("\t")
  #exit
end
