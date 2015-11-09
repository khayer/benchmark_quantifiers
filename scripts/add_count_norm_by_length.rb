lengths = {}
File.open("../annotation/transcript_length.txt").each do |line|
  line.chomp!
  fields = line.split("\t")
  lengths[fields[0]] = fields[-1].to_i / 1000.0
end

puts "gene\tCNT\tCNT_NORM"
File.open("../annotation/EP.counts_for_FPKM.txt").each do |line|
  line.chomp!
  next if line =~ /^gene/
  fields = line.split("\t")
  cnt_norm = fields[1].to_i / lengths[fields[0]]
  fields << cnt_norm.round(4)
  puts fields.join("\t")
end
