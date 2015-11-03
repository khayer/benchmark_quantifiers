require 'minitest_helper'

class TestKallisto < Minitest::Test
  def setup
    @kallisto = Kallisto.new("files/kallisto.tsv")
  end

  def test_read_file
    @kallisto.read_file()
    assert_equal(10.2107, @kallisto.tpm["GENE.6"])
  end
end
