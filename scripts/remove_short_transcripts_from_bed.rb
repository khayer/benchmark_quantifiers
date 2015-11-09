transcripts = {}
File.open("../annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF_score.gtf").each do |line|
  line.chomp!
  next unless line =~ /exon/
  line =~ /\"(ENSMUST\d*)\"/ 
  trans_id = $1
  line =~ /(chr\w+)/
  chr = $1
  #next if transcripts.include?(trans_id)
  transcripts[chr] ||= {}
  transcripts[chr][trans_id] = 0
end

#puts transcripts
#exit
count = 0
File.open("../annotation/ensembl_mm9_nov_2015.bed").each do |line|
  line.chomp!
  
  fields = line.split("\t")
  next unless line =~ /chr[0-9]{1,2}\s|chr[XY]\s/
  if transcripts[fields[0]].keys.include?(fields[3])
    puts line
  else 
    count += 1
    STDERR.puts line
  end
end

STDERR.puts count
