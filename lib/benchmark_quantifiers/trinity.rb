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
    t += "#BSUB -J trinity\n"
    t += "#BSUB -o trinity.%J.out\n"
    t += "#BSUB -e trinity.%J.error\n"
    t += "#BSUB -n 10\n"
    t += "#BSUB -M 16000\n"
    t += "module load java-sdk-1.7.0\n"
    t += "<%= @trinity %> "
    t += "--grid_conf <%= @trinity_grid %>"
    t += "--genome_guided_bam <%= @align_bam %> "
    t += "--genome_guided_max_intron 1000000 "
    t += "--max_memory 10G --CPU 10 "
    t += "--SS_lib_type FR "
    t += "--full_cleanup\n"
    t += "cd trinity_out_dir\n"
    # HARDCODED INDEXES!!!
    t += "<%= @gmap %> -d mm9_ucsc_gmap -D ~/index Trinity-GG.fasta -f 2 > gmap_result.gff\n"
    t += "<%= @gmap %> -D /home/hayer/itmat/benchmark_quantifiers/index/ -d gmap_transcripts Trinity-GG.fasta -f 2 > gmap_result_transcripts.gff\n"
    t += "<%= @trinity_quant %> "
    t += "--transcripts Trinity-GG.fasta "
    t += "--seqType fq "
    t += "--left <%= @fwd_reads %> "
    t += "--right <%= @rev_reads %> "
    t += "--est_method RSEM "
    t += "--aln_method bowtie "
    t += "--trinity_mode "
    t += "--prep_reference "
    t += "--SS_lib_type FR "
    t += "--thread_count 10 \n"
  end

end
