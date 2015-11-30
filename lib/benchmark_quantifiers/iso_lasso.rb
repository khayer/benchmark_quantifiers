class IsoLasso < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
  end

  attr_accessor :filename, :fpkm

  ##/home/hayer/itmat/benchmark_quantifiers/tools/isolasso/bin/isolasso -o iso_res_forceref_MINUS -p 200,56 -x /project/itmatlab/for_katharina/greg_new/annotation/ensembl_mm9_nov_2015_filtered.bed_SORTED --forceref iso_res_forceref_MINUS.instance
  ##count  ID  Chr Dir IsoformStart  IsoformEnd  ExonStart ExonEnd FPKM
  #1 ENSMUST00000160944  chr1  + 3044313 3044813 3044313 3044813 0.000000
  #2 ENSMUST00000162897  chr1  - 3195981 3206425 3195981,3196603,3203689,3204562,3205713 3196603,3197398,3204562,3205713,3206425 1.638401
  #2 ENSMUST00000159265  chr1  - 3196603 3205713 3196603,3203519,3203689,3204562 3197398,3203689,3204562,3205713 3.238384
  #2 ENSMUST00000070533  chr1  - 3204562 3661578 3204562,3205713,3206425,3411782,3660632 3205713,3206425,3207049,3411982,3661578 0.824839

  def read_file()
    File.open(@filename).each do |row|
      row.chomp!
      row = row.split("\t")
      next unless row[2] == "transcript"
      row[-1] =~ /transcript_id \"(\w*\d*)\";/
      trans_id = $1
      row[-1] =~ /FPKM \"(\d*)\";/
      fpkm_v = $1
      @fpkm[trans_id] = fpkm_v.to_f
    end
  end

  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J IsoLasso\n"
    t += "#BSUB -o IsoLasso.%J.out\n"
    t += "#BSUB -e IsoLasso.%J.error\n"
    case mode
    when "default"
      t += "<%= @samtools %> view <%= @align_bam %> | python  <%= @isolasso %> -o iso_res -p <%= @frag_len_mean %>,<%= @frag_len_stddev %> -x <%= @isolasso_ref %> --forceref -\n"
    when "abinitio"
      t += "<%= @samtools %> view <%= @align_bam %> | python  <%= @isolasso %> -o iso_res -p <%= @frag_len_mean %>,<%= @frag_len_stddev %> -x <%= @isolasso_ref %> -\n"
    when "bias"
      t += "<%= @samtools %> view <%= @align_bam %> | python  <%= @isolasso %> -o iso_res -p <%= @frag_len_mean %>,<%= @frag_len_stddev %> -x <%= @isolasso_ref %> --forceref --usebias -\n"
    when "em"
      t += "<%= @samtools %> view <%= @align_bam %> | python  <%= @isolasso %> -o iso_res -p <%= @frag_len_mean %>,<%= @frag_len_stddev %> -x <%= @isolasso_ref %> --forceref --useem -\n"
    end
  end

end
