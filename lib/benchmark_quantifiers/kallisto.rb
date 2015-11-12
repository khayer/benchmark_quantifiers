class Kallisto < FileFormats

  def initialize(filename)
    super(filename)
    @tpm = {}
  end

  attr_accessor :filename, :tpm

  # target_id length  eff_length  est_counts  tpm
  # GENE.1:chr1:134212702-134229870_+ 2936  2687.56 922.162 15.9112
  # GENE.2:chr1:134212702-134230065_+ 3107  2851.35 0 0
  # GENE.3:chr1:8351555-9288654_- 4165  3827.31 3254.32 39.4293
  # GENE.4:chr1:8351555-9289319_- 4884  4557.12 6829.75 69.497

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @tpm[row['target_id'].split(":")[0]] = row['tpm'].to_f
    end
  end

  def template(mode = "default")
    t = "#!/bin/bash -e\n"
    t += "#BSUB -J kallisto\n"
    t += "#BSUB -o kallisto.%J.out\n"
    t += "#BSUB -e kallisto.%J.error\n"
    t += "#BSUB -n 10\n"
    case mode
    when "default"
      t += "<%= @kallisto %> quant -i <%= @kallisto_index %> -o <%= @out_path %> -t 10 <%= @fwd_reads %> <%= @rev_reads %>\n"
    when "bias"
      t += "<%= @kallisto %> quant -i <%= @kallisto_index %> -o <%= @out_path %> -t 10 --bias <%= @fwd_reads %> <%= @rev_reads %>\n"
    end
  end

end
