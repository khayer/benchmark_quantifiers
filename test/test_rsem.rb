require 'minitest_helper'

class TestRSEM < Minitest::Test
  def setup
    @rsem = RSEM.new("files/rsem.isoforms.results")
  end

  def test_read_file
    @rsem.read_file()
    assert_equal(0.11, @rsem.fpkm["ENSMUST00000115585"])
    assert_equal(0.25, @rsem.tpm["ENSMUST00000115585"])
  end
end
