class Sailfish < FileFormats

  def initialize(filename)
    super(filename)
    @tpm = {}
  end

  attr_accessor :filename, :tpm

  ## sailfish (quasi-mapping-based) v0.8.0
  ## [ program ] => sailfish
  ## [ command ] => quant
  ## [ index ] => { /home/hayer/itmat/benchmark_quantifiers/index/sailfish_transcripts_index }
  ## [ libType ] => { ISF }
  ## [ output ] => { sailfish.out }
  ## [ threads ] => { 20 }
  ## [ mates1 ] => { ../fwd.fq }
  ## [ mates2 ] => { ../rev.fq }
  ## [ geneMap ] => { /project/itmatlab/for_katharina/greg_new/annotation/simulator_config_geneinfo_mm9-ensembl-stdchr_GTF.gtf }
  ## [ biasCorrect ] => { }
  ## [ mapping rate ] => { 76.782% }
  ## Name  Length  TPM NumReads
  #ENSMUST00000000001  3262  69.2808 73
  #ENSMUST00000000003  902 13.3608 3
  #ENSMUST00000114041  697 0 0

  def read_file()
    File.open(@filename).each do |line|
      line.chomp!
      next unless line =~ /^ENS/
      target_id, length, tpm_c, num_reads = line.split("\t")
      @tpm[target_id] = tpm_c.to_f
    end
  end

  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J sailfish\n"
    t += "#BSUB -o sailfish.%J.out\n"
    t += "#BSUB -e sailfish.%J.error\n"
    t += "#BSUB -M 12000\n"
    t += "#BSUB -n 20\n"
    t += "<%= @sailfish %> quant -i <%= @sailfish_index %> -l ISF -o sailfish.out -p 20 -1 <%= @fwd_reads %> -2 <%= @rev_reads %> -g <%= @annotation_gtf %> --biasCorrect\n"
  end

end
