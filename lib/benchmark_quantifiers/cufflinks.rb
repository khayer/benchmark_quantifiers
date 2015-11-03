class Cufflinks < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
  end

  attr_accessor :filename, :fpkm

  #tracking_id class_code  nearest_ref_id  gene_id gene_short_name tss_id  locus length  coverage  FPKM  FPKM_conf_lo  FPKM_conf_hi  FPKM_status
  #ENSMUST00000160944  - - ENSMUSG00000090025  - - chr1:3044313-3044814  501 0 0 0 0 OK
  #ENSMUST00000162897  - - CUFF.1  - - chr1:3195981-3206425  4153  49.9727 3.40068 3.08281 3.71856 OK
  #CUFF.1.2  - - CUFF.1  - - chr1:3195981-3661579  5924  5.29947 0.360633  0.260524  0.460743  OK

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @fpkm[row['tracking_id']] = row['FPKM'].to_f
    end
  end

end
