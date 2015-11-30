class Trinity < FileFormats

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
    t += "#BSUB -M 36000\n"
    t += "module load java-sdk-1.7.0\n"
    t += "<%= @trinity %> "
    t += "--grid_conf <%= @trinity_grid %> "
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
    t += "--thread_count 10 --output_dir .\n"
  end

  def Trinity.fix_RSEM_isoforms_results(isoform_results, out_file, transcript_gff, comp)
    #transcript_id gene_id length  effective_length  expected_count  TPM FPKM  IsoPct
    #TRINITY_GG_10000_c0_g1_i1 TRINITY_GG_10000_c0_g1  429 168.37  35.00 5.60  4.76  100.00
    #TRINITY_GG_10001_c0_g1_i1 TRINITY_GG_10001_c0_g1  318 60.17 0.00  0.00  0.00  0.00
    #TRINITY_GG_10002_c0_g1_i1 TRINITY_GG_10002_c0_g1  1820  1559.31 796.86  13.78 11.70 100.00
    #TRINITY_GG_10002_c0_g2_i1 TRINITY_GG_10002_c0_g2  1543  1282.31 82.14 1.73  1.47  100.00
    #TRINITY_GG_10002_c1_g1_i1 TRINITY_GG_10002_c1_g1  377 116.69  4.00  0.92  0.78  100.00
    #TRINITY_GG_10002_c2_g1_i1 TRINITY_GG_10002_c2_g1  369 108.82  6.00  1.49  1.26  100.00
    #TRINITY_GG_10003_c0_g1_i1 TRINITY_GG_10003_c0_g1  259 14.84 1.00  1.82  1.55  100.00
    #TRINITY_GG_10004_c0_g1_i1 TRINITY_GG_10004_c0_g1  418 157.39  0.00  0.00  0.00  0.00
    RSEM.new(isoform_results)
  end

end
