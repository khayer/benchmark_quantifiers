require 'minitest_helper'

class TestMetrics < Minitest::Test
  def setup
    @metrics = Metrics.new("files/metrics_short")
  end

  def test_read_file
    @metrics.read_file()
    assert_equal(3.8382, @metrics.fpkm["ENSMUST00000115484"])
    assert_equal(8.4918, @metrics.tpm["ENSMUST00000115484"])
    assert_equal("ENSMUST00000115484", @metrics.geneid_to_transid["GENE.6"])
  end
end
