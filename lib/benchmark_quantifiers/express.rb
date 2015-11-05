class Express < FileFormats

  def initialize(filename)
    super(filename)
    @fpkm = {}
    @tpm = {}
  end

  attr_accessor :filename, :fpkm, :tpm

  #bundle_id target_id length  eff_length  tot_counts  uniq_counts est_counts  eff_counts  ambig_distr_alpha ambig_distr_bet fpkm  fpkm_conf_low fpkm_conf_high  solvable  tpm
  #1 ENSMUST00000029711  5102  4827.310428 3518  0 23.054884 24.366781 1.453330e+00  2.203137e+02  9.551855e-02  0.000000e+00  2.001197e-01  T 2.224642e-01
  #1 ENSMUST00000107582  4694  4420.611531 3423  52  1612.330361 1712.043381 3.470657e+01  4.027489e+01  7.294603e+00  6.336685e+00  8.252522e+00  T 1.698924e+01
  #1 ENSMUST00000166771  2610  2330.183788 3183  672 2597.531157 2909.451330 8.669877e+01  2.636126e+01  2.229465e+01  2.024968e+01  2.433961e+01  T 5.192457e+01
  #1 ENSMUST00000166866  376 104.715656  167 8 17.083598 61.341667 3.744409e+02  6.179802e+03  3.262855e+00  0.000000e+00  7.267699e+00  T 7.599238e+00
  #2 ENSMUST00000016401  1553  1285.429204 31  0 0.00000 0.000000  8.122719e-04  8.122711e+02  8.109689e-10  0.000000e+00  2.393989e-05  T 1.888759e-09

  def read_file()
    CSV.foreach(@filename, {:headers => true, :col_sep => "\t"}) do |row|
      @fpkm[row['target_id']] = row['fpkm'].to_f
      @tpm[row['target_id']] = row['tpm'].to_f
    end
  end

end
