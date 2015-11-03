class Pennseq < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
  end

  attr_accessor :filename, :fpkm

  #Gene_name Location  Isoform_name  Number_of_Fragments FPKM  Relative_Abundance
  #ENSMUSG00000024335  chr17:34248964-34259262 ENSMUST00000142570  12186 1.0155576127991 0.0154082417225643
  #ENSMUSG00000024335  chr17:34248964-34259262 ENSMUST00000095347  12186 10.5237385638076  0.159668250794054
  #ENSMUSG00000024335  chr17:34248964-34259262 ENSMUST00000148143  12186 7.57475867985775e-100 1.14925742526464e-101
  #ENSMUSG00000024335  chr17:34248964-34259262 ENSMUST00000155286  12186 2.11973206612107e-49  3.21609957428629e-51

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @fpkm[row['Isoform_name']] = row['FPKM'].to_f
    end
  end

end
