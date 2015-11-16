###
#
# IN:
# [hayer@node060 cufflinks]$ find /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/ -name compare_stats.txt | grep -v abinitio
# /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/kallisto/bias/compare_stats.txt
# /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/kallisto/compare_stats.txt
# /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/cufflinks/bias/compare_stats.txt
# /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/cufflinks/compare_stats.txt
# OUT: Summary
#
###
all = []
names = ["Algorithm"]
count = 0
borders = []
first = true
info = {}
ARGV[0..-1].each do |arg|
  tmp = arg.gsub(/(compare_stats.txt$)/,"").split("/")
  ind = tmp.index {|e| e =~ /^VC/}
  algo = tmp[ind+1]
  dataset = tmp[ind]
  mode = tmp[ind+2]
  mode ||= "default"
  #[hayer@node060 cufflinks]$ head /home/hayer/itmat/benchmark_quantifiers/VC_ENSEMBL_PERFECT_LONG/kallisto/bias/compare_stats.txt
  #I, [2015-11-12T12:13:08.387111 #32684]  INFO -- : rmse 17.7616
  #I, [2015-11-12T12:13:08.387453 #32684]  INFO -- : pcc 0.7034
  #I, [2015-11-12T12:13:08.387491 #32684]  INFO -- : spcc 0.4948
  #I, [2015-11-12T12:13:08.387514 #32684]  INFO -- : mrd 0.046
  #I, [2015-11-12T12:13:08.387535 #32684]  INFO -- : All done!
  rmse = 0
  spcc = 0
  mrd = 0
  File.open(arg).each do |line|
    line.chomp!
    fields = line.split(" ")
    if line =~ /rmse/
      rmse = fields[-1].to_f
    elsif line =~ /spcc/
      spcc = fields[-1].to_f
    elsif line =~ /mrd/
      mrd = fields[-1].to_f
    end
  end
  info[algo] ||= {}
  info[algo][mode] ||= {}
  info[algo][mode][dataset] = {:rsme => rsme, :mrd => mrd, :spcc => spcc}
end

puts info
#names.flatten!
##info.flatten!
#
##puts "aligner\ttotal_number_of_bases_of_reads\taccuracy over all bases\taccuracy over uniquely aligned bases"
#
#names.each_with_index do |name, j|
#  print "#{name}\t"
#
#  res = []
#  for i in 0...ARGV.length
#    res << all[i][j]
#  end
#  print res.join("\t")
#  print "\n"
#  case j
#  when borders[0]
#    puts "---------------- READ LEVEL ---------------------"
#  when borders[1]
#    puts "---------------- BASE LEVEL ---------------------"
#  when borders[2]
#    puts "---------------- JUNC LEVEL ---------------------"
#  end
#end
#