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

end
