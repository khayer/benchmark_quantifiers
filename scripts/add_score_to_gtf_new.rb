mapping = {}
File.open("../annotation/IDmapping.txt").each do |line|
  line.chomp!
  fields = line.split("\t")
  mapping[fields[0]] = fields[1]
end

num = {}
File.open("../annotation/EP.counts_for_FPKM_norm.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  fields = line.split("\t")
  num[mapping[fields[0]]] = fields[-1].to_f
end

File.open("../annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF.gtf").each do |line|
  line.chomp!
  if line =~ /^track/
    puts line 
    next
  end
  line =~ /transcript_id \"(ENSMUST\d*)\"/
  trans_id = $1
  #puts trans_id
  fields = line.split("\t")
  num[trans_id] ||= 0
  case 
  when num[trans_id] > 40
    fields[5] = 999
  when num[trans_id] > 0
    fields[5] = 600
  else
    fields[5] = 200
  end
  puts fields.join("\t")
  #exit
end
