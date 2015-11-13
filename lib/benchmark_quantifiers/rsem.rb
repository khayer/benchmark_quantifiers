class RSEM < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
    @tpm = {}
  end

  attr_accessor :filename, :fpkm, :tpm

  #transcript_id  gene_id length  effective_length  expected_count  TPM FPKM  IsoPct
  #ENSMUST00000000001  ENSMUSG00000000001  3262  3000.31 3941.00 79.77 35.76 100.00
  #ENSMUST00000000003  ENSMUSG00000000003  902 640.31  146.08  13.85 6.21  93.48
  #ENSMUST00000114041  ENSMUSG00000000003  697 435.32  6.92  0.97  0.43  6.52
  #ENSMUST00000000028  ENSMUSG00000000028  2143  1881.31 391.42  12.63 5.66  11.68

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @fpkm[row['transcript_id']] = row['FPKM'].to_f
      @tpm[row['transcript_id']] = row['TPM'].to_f
    end
  end

  #bsub -n 15 -M 50000 -N -o rsem.o.log -e rsem.e.log ~/itmat/benchmark_quantifiers/tools/RSEM-1.2.23/rsem-calculate-expression
  #-p 15 --strand-specific --paired-end /project/itmatlab/for_katharina/greg_new/reads/VC.ENS.RPL_fwd.fq
  #/project/itmatlab/for_katharina/greg_new/reads/VC.ENS.RPL_rev.fq
  #~/itmat/benchmark_quantifiers/index/RSEM_mm9_ucsc_all_numbered_chr_transcripts_INDEX rsem_out_RPL
  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J rsem\n"
    t += "#BSUB -o rsem.%J.out\n"
    t += "#BSUB -e rsem.%J.error\n"
    t += "#BSUB -M 50000\n"
    t += "#BSUB -n 10\n"
    case mode
    when "default"
      t += "<%= @rsem %> -p 15 --strand-specific --paired-end <%= @fwd_reads %> <%= @rev_reads %> <%= @rsem_index %> rsem\n"
    end
  end

end
