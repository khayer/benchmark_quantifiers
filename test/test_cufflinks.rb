require 'minitest_helper'

class TestCufflinks < Minitest::Test
  def setup
    @cufflinks = Cufflinks.new("files/cufflinks.isoforms.fpkm_tracking")
  end

  def test_read_file
    @cufflinks.read_file()
    assert_equal(34.9701, @cufflinks.fpkm["ENSMUST00000027032"])
  end
end
