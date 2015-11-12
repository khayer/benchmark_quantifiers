class IReckon < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
  end

  attr_accessor :filename, :fpkm

  #chr1 Alternative transcript  20941707  20945608  0.2 + . gene_id "ENSMUSG00000041809"; transcript_id "ENSMUST00000160782"; RPKM "1.0099876564998218"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.05013927576601671";
  #chr1  Alternative exon  20941707  20941877  0.2 + . gene_id "ENSMUSG00000041809"; transcript_id "ENSMUST00000160782"; exon_number "0"; RPKM "1.0099876564998218"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.05013927576601671";
  #chr1  Alternative exon  20945423  20945608  0.2 + . gene_id "ENSMUSG00000041809"; transcript_id "ENSMUST00000160782"; exon_number "1"; RPKM "1.0099876564998218"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.05013927576601671";
  #chr1  Alternative transcript  21344086  21345197  0.2 + . gene_id "ENSMUSG00000086194"; transcript_id "ENSMUST00000148174"; RPKM "1.9389602603392302"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.0962566844919786";
  #chr1  Alternative exon  21344086  21344183  0.2 + . gene_id "ENSMUSG00000086194"; transcript_id "ENSMUST00000148174"; exon_number "0"; RPKM "1.9389602603392302"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.0962566844919786";
  #chr1  Alternative exon  21344482  21344663  0.2 + . gene_id "ENSMUSG00000086194"; transcript_id "ENSMUST00000148174"; exon_number "1"; RPKM "1.9389602603392302"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.0962566844919786";
  #chr1  Alternative exon  21345107  21345197  0.2 + . gene_id "ENSMUSG00000086194"; transcript_id "ENSMUST00000148174"; exon_number "2"; RPKM "1.9389602603392302"; frac "0"; conf_lo "0"; conf_hi "0"; frac "0"; cov "0.0962566844919786";

  def read_file()
    File.open(@filename).each do |row|
      row.chomp!
      row = row.split("\t")
      next unless row[2] == "transcript"
      row[-1] =~ /transcript_id \"(\w*\d*)\";/
      trans_id = $1
      row[-1] =~ /RPKM \"(\d*\.\d*)\";/
      fpkm_v = $1
      @fpkm[trans_id] = fpkm_v.to_f
    end
  end

  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J ireckon\n"
    t += "#BSUB -o ireckon.%J.out\n"
    t += "#BSUB -e ireckon.%J.error\n"
    t += "#BSUB -n 10\n"
    t += "#BSUB -M 16000\n"
    t += "java -Xmx15000M -jar "
    case mode
    when "default"
      t += "<%= @ireckon %> <%= @align_bam %> <%= @genome_fa %> <%= @ireckon_ucsc %> -1 <%= @fwd_reads %> -2 <%= @rev_reads %> -o . -n 10 -b 0 -novel 0\n"
    when "abinitio"
      t += "<%= @ireckon %> <%= @align_bam %> <%= @genome_fa %> <%= @ireckon_ucsc %> -1 <%= @fwd_reads %> -2 <%= @rev_reads %> -o . -n 10 -b 0 -novel 1\n"
    when "bias_1"
      t += "<%= @ireckon %> <%= @align_bam %> <%= @genome_fa %> <%= @ireckon_ucsc %> -1 <%= @fwd_reads %> -2 <%= @rev_reads %> -o . -n 10 -b 1 -novel 0\n"
    when "bias_2"
      t += "<%= @ireckon %> <%= @align_bam %> <%= @genome_fa %> <%= @ireckon_ucsc %> -1 <%= @fwd_reads %> -2 <%= @rev_reads %> -o . -n 10 -b 2 -novel 0\n"
    end
  end

end
