class Metrics < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
    @tpm = {}
    @geneid_to_transid = {}
  end

  attr_accessor :filename, :fpkm, :tpm,:geneid_to_transid

  #GENEID trans_id  gene_id length  #exons  effective_length  FPKM  TPM
  #GENE.1  ENSMUST00000072177  ENSMUSG00000009772  2928  8 2659.39 6.6857  14.7917
  #GENE.2  ENSMUST00000082125  ENSMUSG00000009772  3100  7 2831.39 0 0
  #GENE.3  ENSMUST00000132064  ENSMUSG00000025909  4145  20  3876.39 17.2547 38.1749

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @fpkm[row['trans_id']] = row['FPKM'].to_f
      @tpm[row['trans_id']] = row['TPM'].to_f
      @geneid_to_transid[row['GENEID']] = row['trans_id']
    end
  end

end
