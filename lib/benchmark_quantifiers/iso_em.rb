class IsoEM < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
  end

  attr_accessor :filename, :fpkm

  #ENSMUST00000028280  161.89187479178383
  #ENSMUST00000098250  161.43690525901724
  #ENSMUST00000022460  101.11477981724822
  #ENSMUST00000088373  93.73980126160508
  #ENSMUST00000112390  93.21642438589376

  def read_file()
    CSV.foreach(@filename, {:headers => false, :col_sep => "\t"}) do |row|
      @fpkm[row[0]] = row[1].to_f
      #@tpm[row['transcript_id']] = row['TPM'].to_f
    end
  end

  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J IsoEM\n"
    t += "#BSUB -o IsoEM.%J.out\n"
    t += "#BSUB -e IsoEM.%J.error\n"
    t += "#BSUB -M 40000\n"
    case mode
      # -c  -m 260 -d 40 -s ../VC.ENS.PL.sam
    when "default"
      t += "<%= @isoem %> -G <%= @annotation_gtf %> -c <%= @isoem_cluster %> -m <%= @frag_len_mean %> -n <%= @frag_len_stddev %> -s <%= @align_bam %>\n"
    when "bias"
      t += "<%= @isoem %> -G <%= @annotation_gtf %> -c <%= @isoem_cluster %> -m <%= @frag_len_mean %> -n <%= @frag_len_stddev %> -b yes -s <%= @align_bam %>\n"
    end
  end

end
