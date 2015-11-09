
junction_file = ARGV[0]

# Get rid of header
l = `grep ^chr #{junction_file} > #{junction_file}_tmp`
puts l

# Sorting
l = `sort -k1,1 -k2,2n #{junction_file}_tmp > #{junction_file}_tmp_s`
puts l

# Set score to 1000
l = `awk  '{$5 = "1000"; print} ' FS='\t' OFS='\t' #{junction_file}_tmp_s  > #{junction_file}_tmp_ss`
puts l

# Turn into BigBed
l = `bedToBigBed #{junction_file}_tmp_ss ../for_greg_refseq/mm9.chrom.sizes #{junction_file}.bb`

